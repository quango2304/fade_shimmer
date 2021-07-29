# fade_shimmer

A fade shimmer library to implement loading like latest facebook loading effect.

##demo
![](demo.gif)

## example
create rounded loading
```
      FadeShimmer.round(
        size: 60,
        fadeTheme: isDarkMode ? FadeTheme.dark : FadeTheme.light,
      )
```
create loading with custom size and color
```
      FadeShimmer(
        height: 8,
        width: 150,
        radius: 4,
        highlightColor: Color(0xffF9F9FB),
        baseColor: Color(0xffE6E8EB),
      )
```