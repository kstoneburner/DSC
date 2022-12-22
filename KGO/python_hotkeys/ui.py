# https://github.com/chriskiehl/Gooey#layout-customization

# app.py
from gooey import Gooey, GooeyParser

def do_stuff(args=None):
    print(f"The file you chose is {args.file_path}")
    print(f"The folder you chose is {args.directory_path}")
    print(f"The first checkbox value is {args.checkbox_1}")
    print(f"The second checkbox value is {args.checkbox_2}")

    if args.checkbox_1:
        print(f"The first checkbox is unchecked")

    else:
        print(f"The first checkbox is checked")

    if args.checkbox_2:
        print(f"The second checkbox is checked")
        
    else:
        print(f"The second checkbox is unchecked")   

    print("All done!")

@Gooey(
    program_name="Gooey Demo",
    program_description="Demonstrate Gooey features",
    default_size=(600, 500),
)

def main():
    parser = GooeyParser()

    gp = parser.add_argument_group("Group 1")
    parser.add_argument(
        "text",
        metavar="Rule Name",
        #help="Text to be processed",
        type=str,
        default="",
    )

    parser.add_argument(
        "check",
        metavar="Rule Name",
        #help="Text to be processed",
        type=str,
        default="",
    )

    gp.add_argument(
        "-b",
        "--directory_path",
        metavar="Directory Chooser",
        help="Choose a folder",
        widget="DirChooser",
    )

    gp = parser.add_argument_group("Group 2")
    gp.add_argument(
        "-c",
        "--checkbox_1",
        metavar="Checkbox 1",
        help="Checkbox that is checked by default",
        widget="CheckBox",
        action="store_false",
        default=True,  
    )

    gp.add_argument(
        "-e",
        "--checkbox_3",
        metavar="Checkbox 3",
        help="Checkbox that is checked by default",
        widget="CheckBox",
        action="store_false",
        default=True,  
    )

    gp.add_argument(
        "-d",
        "--checkbox_2",
        metavar="Checkbox 2",        
        help="Checkbox that is unchecked by default",
        widget="CheckBox",
        action="store_true",
        default=False,        
    )
    
    args = parser.parse_args()

    do_stuff(args)

if __name__ == "__main__":
    main()