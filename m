Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731326D895A
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Apr 2023 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDEVLN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Apr 2023 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjDEVLM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Apr 2023 17:11:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F28211F
        for <linux-pwm@vger.kernel.org>; Wed,  5 Apr 2023 14:11:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j24so37563068wrd.0
        for <linux-pwm@vger.kernel.org>; Wed, 05 Apr 2023 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680729067; x=1683321067;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+KHuMYx1P9ZE36O7O/T0L+F+FyesC3actOk5hU1hv8=;
        b=2ejslFaM8i5DoR1oyfUUIwH07n7n+OnE88TxXe3ld/ubfps3gBJo+5hkiER6Bqxgv7
         C5ZOce3y2mdvhZipnneoVkyPHMNNBgSkxYM28meMtkHYapqDrs97uukN/mW1m+HdfRS/
         GTYX6cFOi4Lh0vKYj7JVkVCzitBcyuKXkDNYCEGwcVQ/ovmaP2XYzEJi32sUlMHVeeFO
         uYb9CRmzxBZufmY3tt9/TrfFeTw9aPrzyKAAyZAhiLuJvOLN0bL+ynniX0Th6D0zgp8t
         /IILRaHWw6apFvCXuzsXmf02GpeX3aVlEG2Lqi4nIedboz/ERk7OSiaE+K+BKtUXMX1f
         ROow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680729067; x=1683321067;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7+KHuMYx1P9ZE36O7O/T0L+F+FyesC3actOk5hU1hv8=;
        b=b1Gbi6FxqvAglP/HhZHic8XRs+XWEJ5YCoQSygjM3wLjpPRGpXcBXAerLdLLdi9X/e
         j0IQXQuEaz5SFC7QX49ryIp4KB8crXZfwl9pqtIt+tspcCtvGoYZTOpHaGZutofUf9Z6
         7Kx6euf3vW0vPrTBLWRHugMhuwjC9MlUPaPJ7G0qXAV8RIhpoCqhYS155u5XcDv4kh5G
         yGL/4Ih0LewVKhJ93Zu+Z91JKPUTk5D/WBsRV+F7IJV1eDuVBgrBznKHxz9zGzwPEeNV
         r/kh/m+NKUgMCzpavDdlLiEBNZzPqHmMuKKb0U+soONaOAJ4l5Ho/im4B1dSQLRjgqX1
         3aqg==
X-Gm-Message-State: AAQBX9fJhX9kDU5McKksr//AnvEA8MY0EqWOTmIt0qXgjRY/2jT71AOy
        zp5VCtVKCWoHT+IQxgtfy7wweWuf+I/0JD88Z+c=
X-Google-Smtp-Source: AKy350arxlJFKdAeu6dXJqBMnrETuK9mm1BEYiGhXG7AGV93hVykhKnFnEZxFuoP82THOR4+oe+B+w==
X-Received: by 2002:adf:dec2:0:b0:2cf:fd6:b83f with SMTP id i2-20020adfdec2000000b002cf0fd6b83fmr3173546wrn.8.1680729067083;
        Wed, 05 Apr 2023 14:11:07 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id q12-20020adff78c000000b002c5d3f0f737sm15850148wrp.30.2023.04.05.14.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:11:06 -0700 (PDT)
References: <abf03223-5745-0c79-7840-176c551134c5@gmail.com>
 <CAFBinCBvubso9G3hrJxCumFYcn1ggZhpsJsLA9Qehas4PH5RoQ@mail.gmail.com>
 <17f97070-cc2b-2c86-7de2-3ca07b14ce4e@gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC/RFT] pwm: meson: make full use of common clock
 framework
Date:   Wed, 05 Apr 2023 22:59:25 +0200
In-reply-to: <17f97070-cc2b-2c86-7de2-3ca07b14ce4e@gmail.com>
Message-ID: <1jv8iajaqd.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Wed 05 Apr 2023 at 22:43, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 03.04.2023 23:01, Martin Blumenstingl wrote:
>> Hello Heiner,
>>=20
>> On Tue, Mar 28, 2023 at 10:59=E2=80=AFPM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
>>>
>>> Newer versions of the PWM block use a core clock with external mux,
>>> divider, and gate. These components either don't exist any longer in
>>> the PWM block, or they are bypassed.
>>> To minimize needed changes for supporting the new version, the internal
>>> divider and gate should be handled by CCF too.
>> That sounds like a good way forward to me
>>=20
>>> I didn't see a good way to split the patch, therefore it's somewhat
>>> bigger. What it does:
>>>
>>> - The internal mux is handled by CCF already. Register also internal
>>>   divider and gate with CCF, so that we have one representation of the
>>>   input clock: [mux] parent of [divider] parent of [gate]
>>>
>>> - Now that CCF selects an appropriate mux parent, we don't need the
>>>   DT-provided default parent any longer. Accordingly we can also omit
>>>   setting the mux parent directly in the driver.
>>>
>>> - Instead of manually handling the pre-div divider value, let CCF
>>>   set the input clock. Targeted input clock frequency is
>>>   0xffff * 1/period for best precision.
>>>
>>> - For the "inverted pwm disabled" scenario target an input clock
>>>   frequency of 1GHz. This ensures that the remaining low pulses
>>>   have minimum length.
>> Unfortunately I didn't have much time today so I didn't get to reviewing=
 this.
>>=20
>>> I don't have hw with the old PWM block, therefore I couldn't test this
>>> patch. With the not yet included extension for the new PWM block
>>> (channel->clock directly coming from get_clk(external_clk)) I didn't
>>> notice any problem. My system uses PWM for the CPU voltage regulator
>>> and for the SDIO 32kHz clock.
>>>
>>> Note: The clock gate in the old PWM block is permanently disabled.
>>> This seems to indicate that it's not used by the new PWM block.
>>>
>>> I'd appreciate testing on the different platforms using the old
>>> PWM block.
>> I have tested basic functionality on a X96 Air (SM1 SoC, the version
>> with Gbit/s PHY) where the VDDCPU regulator is PWM based and the 32kHz
>> clock for wifi is generated by the PWM controller.
>> The RTL8822CS SDIO wifi card is still working (firmware download,
>> basic connectivity and connecting to an AP) and the system survived a
>> minute of 100% CPU usage without hanging.
>>=20
>> For reference:
>> # cat /sys/kernel/debug/pwm
>> platform/ffd19000.pwm, 2 PWM devices
>> pwm-0   (wifi32k             ): requested enabled period: 30518 ns
>> duty: 15259 ns polarity: normal
>> pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
>>=20
>> platform/ff807000.pwm, 2 PWM devices
>> pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
>> pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
>>=20
>> platform/ff802000.pwm, 2 PWM devices
>> pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
>> pwm-1   (regulator-vddcpu    ): requested enabled period: 1500 ns
>> duty: 1125 ns polarity: normal
>>=20
>> # grep \.pwm /sys/kernel/debug/clk/clk_summary
>>                ffd19000.pwm#mux0       1        1        0   648999985
>>          0     0  50000         Y
>>                   ffd19000.pwm#div0       1        1        0
>> 648999985          0     0  50000         Y
>>                      ffd19000.pwm#gate0       1        1        0
>> 648999985          0     0  50000         Y
>>    ffd19000.pwm#mux1                 0        0        0    24000000
>>        0     0  50000         Y
>>       ffd19000.pwm#div1              0        0        0    24000000
>>        0     0  50000         Y
>>          ffd19000.pwm#gate1          0        0        0    24000000
>>        0     0  50000         N
>>    ff807000.pwm#mux1                 0        0        0    24000000
>>        0     0  50000         Y
>>       ff807000.pwm#div1              0        0        0    24000000
>>        0     0  50000         Y
>>          ff807000.pwm#gate1          0        0        0    24000000
>>        0     0  50000         N
>>    ff807000.pwm#mux0                 0        0        0    24000000
>>        0     0  50000         Y
>>       ff807000.pwm#div0              0        0        0    24000000
>>        0     0  50000         Y
>>          ff807000.pwm#gate0          0        0        0    24000000
>>        0     0  50000         N
>>    ff802000.pwm#mux1                 1        1        0    24000000
>>        0     0  50000         Y
>>       ff802000.pwm#div1              1        1        0    24000000
>>        0     0  50000         Y
>>          ff802000.pwm#gate1          1        1        0    24000000
>>        0     0  50000         Y
>>    ff802000.pwm#mux0                 0        0        0    24000000
>>        0     0  50000         Y
>>       ff802000.pwm#div0              0        0        0    24000000
>>        0     0  50000         Y
>>          ff802000.pwm#gate0          0        0        0    24000000
>>        0     0  50000         N
>>=20
>> hdmi_pll is the parent of ffd19000.pwm#mux0 - before it was using the
>> 24MHz XTAL.
>> I haven't tested what happens when I change the video mode (that board
>> is currently not connected to any HDMI screen).
>>=20
>
> That's a good point. AFAICS drivers/gpu/drm/meson/meson_vclk.c fiddles
> with the hdmi clock registers. So we may want to avoid using hdmi_pll
> or vid_pll as pwm parent. Below is a quick (and hopefully not too dirty)
> follow-up patch disabling the hdmi/video clock parent.
> Would be great if you can test this patch on top.
>
>> Later this week I can also try this e.g. on my Odroid-C1 (with 32-bit
>> Meson8b SoC) to verify that we don't have any 32-bit compatibility
>> issues.
>>=20
>>=20
>> Best regards,
>> Martin
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 2b1debda4..81900e03a 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -348,7 +348,7 @@ static const struct pwm_ops meson_pwm_ops =3D {
>  };
>=20=20
>  static const char * const pwm_meson8b_parent_names[] =3D {
> -	"xtal", "vid_pll", "fclk_div4", "fclk_div3"
> +	"xtal", "fclk_div4", "fclk_div3"
>  };
>=20=20
>  static const struct meson_pwm_data pwm_meson8b_data =3D {
> @@ -357,7 +357,7 @@ static const struct meson_pwm_data pwm_meson8b_data =
=3D {
>  };
>=20=20
>  static const char * const pwm_gxbb_parent_names[] =3D {
> -	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
> +	"xtal", "fclk_div4", "fclk_div3"
>  };
>=20=20
>  static const struct meson_pwm_data pwm_gxbb_data =3D {
> @@ -415,7 +415,7 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_dat=
a =3D {
>  };
>=20=20
>  static const char * const pwm_g12a_ee_parent_names[] =3D {
> -	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
> +	"xtal", "fclk_div4", "fclk_div3"
>  };
>=20=20
>  static const struct meson_pwm_data pwm_g12a_ee_data =3D {
> @@ -470,6 +470,7 @@ static int meson_pwm_init_channels(struct meson_pwm *=
meson)
>=20=20
>  	for (i =3D 0; i < meson->chip.npwm; i++) {
>  		struct meson_pwm_channel *channel =3D &meson->channels[i];
> +		static const u32 mux_parents_wo_vid[] =3D {0, 2, 3};
>  		const char *clk_parent[1];
>  		struct clk *mux_clk, *div_clk;
>=20=20
> @@ -490,6 +491,10 @@ static int meson_pwm_init_channels(struct meson_pwm =
*meson)
>  		channel->mux.table =3D NULL;
>  		channel->mux.hw.init =3D &init;
>=20=20
> +		/* 3 parents indicates that video clock parent should be omitted */
> +		if (init.num_parents =3D=3D 3)
> +			 channel->mux.table =3D mux_parents_wo_vid;
> +

If you are reworking the pwm driver and its clock usage, I would suggest
to also stop using global clock names within the driver. The way it is
used right now is not great. It is essentially the pwm driver directly
poking the clock tree, without going through DT as it should.

You could have clkin0/1/2/3 from DT, using fw_name for the clock mux.
This how it should be used. All input being optionnal, you would not any
dirty trick in the driver to skip an input. You would just not provide
it through DT.

This approach would be compatible with all the SoCs (compared to our
current approach which require a new table for each SoC)

Off the course the bindings would be different, so it would probably
require a new compatible (-v2 ?)

>  		mux_clk =3D devm_clk_register(dev, &channel->mux.hw);
>  		if (IS_ERR(mux_clk)) {
>  			err =3D PTR_ERR(mux_clk);

