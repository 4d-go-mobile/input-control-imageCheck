package ___PACKAGE___

import android.view.View
import android.widget.ImageView
import androidx.core.content.ContextCompat
import com.qmobile.qmobiledatasync.utils.BaseKotlinInputControl
import com.qmobile.qmobiledatasync.utils.KotlinInputControl
import com.qmobile.qmobileui.ui.setOnSingleClickListener
import ___APP_PACKAGE___.R

@KotlinInputControl
class ImageCheck(view: View) : BaseKotlinInputControl {

    override val autocomplete: Boolean = true

    private var imageView: ImageView = view.findViewById(R.id.image_view)

    private val offDrawable = ContextCompat.getDrawable(view.context, R.drawable.image_check_off)
    private val onDrawable = ContextCompat.getDrawable(view.context, R.drawable.image_check_on)

    private var isOn = false

    override fun process(inputValue: Any?, outputCallback: (output: Any) -> Unit) {
        if (inputValue is Boolean) {
            isOn = inputValue
            setImage(inputValue)
        }

        imageView.setOnSingleClickListener {
            isOn = !isOn
            setImage(isOn)
            outputCallback(isOn)
        }
    }

    private fun setImage(boolValue: Boolean) {
        if (boolValue) {
            imageView.setImageDrawable(onDrawable)
        } else {
            imageView.setImageDrawable(offDrawable)
        }
    }
}
