default:
	jekyll build

clean:
	jekyll clean

serve:
	jekyll serve

publish: default
	rsync -rcpv --chmod=a+r _site/ swier004@csstaff.science.uu.nl:/users/www/docs/vakken/afp

publishalejandro: default
	rsync -rcpv --chmod=a+r _site/ f100183@csstaff.science.uu.nl:/users/www/docs/vakken/afp
