Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4517B6D88ED
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Apr 2023 22:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjDEUoa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Apr 2023 16:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjDEUoJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Apr 2023 16:44:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F77786AD
        for <linux-pwm@vger.kernel.org>; Wed,  5 Apr 2023 13:43:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so2597059wms.1
        for <linux-pwm@vger.kernel.org>; Wed, 05 Apr 2023 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680727436;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH2rOLhl4vFsik3GDj+s+C4c89YKolYhU+ZaEGUTglU=;
        b=Eawgqj644gV+BSNj14yWAAwzp829p/5IkiUWWYh3zFM9zpM0qr/Vrtl5L4OxbLobil
         orIVHvOM810DoYZBEpBTRoNFsspR4r+LDBlUUVeMWBt+/uJ4lqUhXFtPbIwC8h9XXQdE
         ZzDFgDCWxk05+oKiGCtXNYuGHymDJXSn/gx6cZMjIHVAIE6mNrbBgAajvzV30bCaLgyC
         tRVeps3pAt5Qm+9ifh9BLE2JTtSmZQBRoo6TC6C5WOBKvdMHkSBJSwSakOpzKQA/4m9Z
         6vWtF9LQ3ShoykrRFGMTXYh+FFDLyc5eyru4RHn03gjMoUqrMIhbUEe7u03g1O746uVL
         gEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680727436;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH2rOLhl4vFsik3GDj+s+C4c89YKolYhU+ZaEGUTglU=;
        b=vu2Jyfoq1i2ZvgB/05ohf5nzL0KsrmiR2tT7xrD8EeL9x51fuv28ySlckJWP3wUbrB
         RESsX9f/4+pnonspp2xWTmDNMy8wZqqZFciF/9tKl50JSWdtyqSNnY8C1lGzn5A+apRN
         zR4MUXiET3liQWS9oub7a21U/BxowFDxCoiNpoztI3f7e/0rwzgTz7T7yIAf8vrhx/Bl
         /Qp0c8Yrx5YAImX69x92nngzEfpa+wBtJECq6p0KuBXsICNVaxw+lAKPX4+a39tEwCL2
         X3UHh3rjZdeLQdRm1GFhAwFwfjV0izQxD7hZ0G1Y24qvXTQEw0nz/aQSZtk3FfxDomHh
         bs2A==
X-Gm-Message-State: AAQBX9cLp2Fk4Z/Lkpbighg89CIeFv3OA414dUf8weQFs3CkjiPP6hTU
        rGYbhCJEwmXSLx+r4sHdtdM=
X-Google-Smtp-Source: AKy350b1wX1xpengPKLE0Lpf1lQEtYSgvswLkLqa3mNI0u8F2wK9DTQ8AaIkptHAPRzGXa+ggTyX1A==
X-Received: by 2002:a7b:c41a:0:b0:3f0:4428:94fa with SMTP id k26-20020a7bc41a000000b003f0442894famr5592407wmi.26.1680727435703;
        Wed, 05 Apr 2023 13:43:55 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72d5:8b00:607f:2e91:b485:d79e? (dynamic-2a01-0c22-72d5-8b00-607f-2e91-b485-d79e.c22.pool.telefonica.de. [2a01:c22:72d5:8b00:607f:2e91:b485:d79e])
        by smtp.googlemail.com with ESMTPSA id b2-20020a05600c4e0200b003f04057bf1bsm3199680wmq.18.2023.04.05.13.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 13:43:55 -0700 (PDT)
Message-ID: <17f97070-cc2b-2c86-7de2-3ca07b14ce4e@gmail.com>
Date:   Wed, 5 Apr 2023 22:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <abf03223-5745-0c79-7840-176c551134c5@gmail.com>
 <CAFBinCBvubso9G3hrJxCumFYcn1ggZhpsJsLA9Qehas4PH5RoQ@mail.gmail.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH RFC/RFT] pwm: meson: make full use of common clock
 framework
In-Reply-To: <CAFBinCBvubso9G3hrJxCumFYcn1ggZhpsJsLA9Qehas4PH5RoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 03.04.2023 23:01, Martin Blumenstingl wrote:
> Hello Heiner,
> 
> On Tue, Mar 28, 2023 at 10:59 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Newer versions of the PWM block use a core clock with external mux,
>> divider, and gate. These components either don't exist any longer in
>> the PWM block, or they are bypassed.
>> To minimize needed changes for supporting the new version, the internal
>> divider and gate should be handled by CCF too.
> That sounds like a good way forward to me
> 
>> I didn't see a good way to split the patch, therefore it's somewhat
>> bigger. What it does:
>>
>> - The internal mux is handled by CCF already. Register also internal
>>   divider and gate with CCF, so that we have one representation of the
>>   input clock: [mux] parent of [divider] parent of [gate]
>>
>> - Now that CCF selects an appropriate mux parent, we don't need the
>>   DT-provided default parent any longer. Accordingly we can also omit
>>   setting the mux parent directly in the driver.
>>
>> - Instead of manually handling the pre-div divider value, let CCF
>>   set the input clock. Targeted input clock frequency is
>>   0xffff * 1/period for best precision.
>>
>> - For the "inverted pwm disabled" scenario target an input clock
>>   frequency of 1GHz. This ensures that the remaining low pulses
>>   have minimum length.
> Unfortunately I didn't have much time today so I didn't get to reviewing this.
> 
>> I don't have hw with the old PWM block, therefore I couldn't test this
>> patch. With the not yet included extension for the new PWM block
>> (channel->clock directly coming from get_clk(external_clk)) I didn't
>> notice any problem. My system uses PWM for the CPU voltage regulator
>> and for the SDIO 32kHz clock.
>>
>> Note: The clock gate in the old PWM block is permanently disabled.
>> This seems to indicate that it's not used by the new PWM block.
>>
>> I'd appreciate testing on the different platforms using the old
>> PWM block.
> I have tested basic functionality on a X96 Air (SM1 SoC, the version
> with Gbit/s PHY) where the VDDCPU regulator is PWM based and the 32kHz
> clock for wifi is generated by the PWM controller.
> The RTL8822CS SDIO wifi card is still working (firmware download,
> basic connectivity and connecting to an AP) and the system survived a
> minute of 100% CPU usage without hanging.
> 
> For reference:
> # cat /sys/kernel/debug/pwm
> platform/ffd19000.pwm, 2 PWM devices
> pwm-0   (wifi32k             ): requested enabled period: 30518 ns
> duty: 15259 ns polarity: normal
> pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
> 
> platform/ff807000.pwm, 2 PWM devices
> pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
> pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
> 
> platform/ff802000.pwm, 2 PWM devices
> pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
> pwm-1   (regulator-vddcpu    ): requested enabled period: 1500 ns
> duty: 1125 ns polarity: normal
> 
> # grep \.pwm /sys/kernel/debug/clk/clk_summary
>                ffd19000.pwm#mux0       1        1        0   648999985
>          0     0  50000         Y
>                   ffd19000.pwm#div0       1        1        0
> 648999985          0     0  50000         Y
>                      ffd19000.pwm#gate0       1        1        0
> 648999985          0     0  50000         Y
>    ffd19000.pwm#mux1                 0        0        0    24000000
>        0     0  50000         Y
>       ffd19000.pwm#div1              0        0        0    24000000
>        0     0  50000         Y
>          ffd19000.pwm#gate1          0        0        0    24000000
>        0     0  50000         N
>    ff807000.pwm#mux1                 0        0        0    24000000
>        0     0  50000         Y
>       ff807000.pwm#div1              0        0        0    24000000
>        0     0  50000         Y
>          ff807000.pwm#gate1          0        0        0    24000000
>        0     0  50000         N
>    ff807000.pwm#mux0                 0        0        0    24000000
>        0     0  50000         Y
>       ff807000.pwm#div0              0        0        0    24000000
>        0     0  50000         Y
>          ff807000.pwm#gate0          0        0        0    24000000
>        0     0  50000         N
>    ff802000.pwm#mux1                 1        1        0    24000000
>        0     0  50000         Y
>       ff802000.pwm#div1              1        1        0    24000000
>        0     0  50000         Y
>          ff802000.pwm#gate1          1        1        0    24000000
>        0     0  50000         Y
>    ff802000.pwm#mux0                 0        0        0    24000000
>        0     0  50000         Y
>       ff802000.pwm#div0              0        0        0    24000000
>        0     0  50000         Y
>          ff802000.pwm#gate0          0        0        0    24000000
>        0     0  50000         N
> 
> hdmi_pll is the parent of ffd19000.pwm#mux0 - before it was using the
> 24MHz XTAL.
> I haven't tested what happens when I change the video mode (that board
> is currently not connected to any HDMI screen).
> 

That's a good point. AFAICS drivers/gpu/drm/meson/meson_vclk.c fiddles
with the hdmi clock registers. So we may want to avoid using hdmi_pll
or vid_pll as pwm parent. Below is a quick (and hopefully not too dirty)
follow-up patch disabling the hdmi/video clock parent.
Would be great if you can test this patch on top.

> Later this week I can also try this e.g. on my Odroid-C1 (with 32-bit
> Meson8b SoC) to verify that we don't have any 32-bit compatibility
> issues.
> 
> 
> Best regards,
> Martin

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2b1debda4..81900e03a 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -348,7 +348,7 @@ static const struct pwm_ops meson_pwm_ops = {
 };
 
 static const char * const pwm_meson8b_parent_names[] = {
-	"xtal", "vid_pll", "fclk_div4", "fclk_div3"
+	"xtal", "fclk_div4", "fclk_div3"
 };
 
 static const struct meson_pwm_data pwm_meson8b_data = {
@@ -357,7 +357,7 @@ static const struct meson_pwm_data pwm_meson8b_data = {
 };
 
 static const char * const pwm_gxbb_parent_names[] = {
-	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
+	"xtal", "fclk_div4", "fclk_div3"
 };
 
 static const struct meson_pwm_data pwm_gxbb_data = {
@@ -415,7 +415,7 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
 };
 
 static const char * const pwm_g12a_ee_parent_names[] = {
-	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
+	"xtal", "fclk_div4", "fclk_div3"
 };
 
 static const struct meson_pwm_data pwm_g12a_ee_data = {
@@ -470,6 +470,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
+		static const u32 mux_parents_wo_vid[] = {0, 2, 3};
 		const char *clk_parent[1];
 		struct clk *mux_clk, *div_clk;
 
@@ -490,6 +491,10 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		channel->mux.table = NULL;
 		channel->mux.hw.init = &init;
 
+		/* 3 parents indicates that video clock parent should be omitted */
+		if (init.num_parents == 3)
+			 channel->mux.table = mux_parents_wo_vid;
+
 		mux_clk = devm_clk_register(dev, &channel->mux.hw);
 		if (IS_ERR(mux_clk)) {
 			err = PTR_ERR(mux_clk);
-- 
2.40.0


