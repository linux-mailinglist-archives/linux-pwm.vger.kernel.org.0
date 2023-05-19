Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73296709B58
	for <lists+linux-pwm@lfdr.de>; Fri, 19 May 2023 17:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjESPa1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 May 2023 11:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjESPaZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 May 2023 11:30:25 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF91B3
        for <linux-pwm@vger.kernel.org>; Fri, 19 May 2023 08:30:22 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5841160C02;
        Fri, 19 May 2023 18:30:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684510220;
        bh=FM3XQHIvBazKOyaGIdvJJG1Xxh1oXLVwed2SJetAZxw=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=pEaO+8yICfGZmQX/lwpykshREOEuufR8DVfW0SBCUDgTAF6+85lk5jIaLZw/U4y6M
         Br+q8AqWpOJi+wftmaXAlks/81gExyaIOLTEb0OZkV2QsgcBw0DNQ26lj1N9BFy6JO
         KHy4AaWIfPxJM1AqTkq7IfarKLANFn4WPYtgOMofcB8TZJNBSJm5Fa338I4ygN++mD
         E712LcV8XxKZ8LhEemqd8UOJ+fvtxAqnK5/0ERV4stJ04S8CzAeNy7icGZ/sgkPAQd
         KbUp8M2baTeSe5sXq4wLE89CeJpDf59mNO3839x3yxQe2lcds/OB7oG3Y4kL97B4ni
         pcNbfggQ/2WUQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 19 May 2023 18:30:19 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Heiner Kallweit <hkallweit1@gmail.com>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "rockosov@gmail.com" <rockosov@gmail.com>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock
 framework
Thread-Topic: [PATCH v4 4/4] pwm: meson: make full use of common clock
 framework
Thread-Index: AQHZimbR5zQfWI/tB0mpsvpAczxBaA==
Date:   Fri, 19 May 2023 15:30:19 +0000
Message-ID: <tyuyderm7i6otsgrntw2wj4k4ii5xwp2vngfa76eaguki7yuqa@322cjuotnr6q>
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
In-Reply-To: <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.24]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1463AB5D3BAB0D44817600A52E19179A@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/19 11:16:00 #21342682
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Heiner,

Thank you for the patch series!

I am currently working on the Amlogic A1 clock driver and other
peripheral devices, including PWM. During a discussion about the clock
driver with Martin Blumenstingl, we found an intersection between the
clock driver and your PWM CCF support patch series. Please see my
comments below.

On Thu, Apr 13, 2023 at 07:54:46AM +0200, Heiner Kallweit wrote:
> Newer versions of the PWM block use a core clock with external mux,
> divider, and gate. These components either don't exist any longer in
> the PWM block, or they are bypassed.
> To minimize needed changes for supporting the new version, the internal
> divider and gate should be handled by CCF too.
>=20
> I didn't see a good way to split the patch, therefore it's somewhat
> bigger. What it does:
>=20
> - The internal mux is handled by CCF already. Register also internal
>   divider and gate with CCF, so that we have one representation of the
>   input clock: [mux] parent of [divider] parent of [gate]
>  =20
> - Now that CCF selects an appropriate mux parent, we don't need the
>   DT-provided default parent any longer. Accordingly we can also omit
>   setting the mux parent directly in the driver.
>  =20
> - Instead of manually handling the pre-div divider value, let CCF
>   set the input clock. Targeted input clock frequency is
>   0xffff * 1/period for best precision.
>  =20
> - For the "inverted pwm disabled" scenario target an input clock
>   frequency of 1GHz. This ensures that the remaining low pulses
>   have minimum length.
>=20
> I don't have hw with the old PWM block, therefore I couldn't test this
> patch. With the not yet included extension for the new PWM block
> (channel->clk coming directly from get_clk(external_clk)) I didn't
> notice any problem. My system uses PWM for the CPU voltage regulator
> and for the SDIO 32kHz clock.
>=20
> Note: The clock gate in the old PWM block is permanently disabled.
> This seems to indicate that it's not used by the new PWM block.
>=20
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> Changes to RFT/RFC version:
> - use parent_hws instead of parent_names for div/gate clock
> - use devm_clk_hw_register where the struct clk * returned by
>   devm_clk_register isn't needed
>=20
> v2:
> - add patch 1
> - add patch 3
> - switch to using clk_parent_data in all relevant places
> v3:
> - add flag CLK_IGNORE_UNUSED
> v4:
> - remove variable tmp in meson_pwm_get_state
> - don't use deprecated function devm_clk_register

[...]

> @@ -166,7 +158,11 @@ static int meson_pwm_calc(struct meson_pwm *meson, s=
truct pwm_device *pwm,
>  	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
>  		duty =3D period - duty;
> =20
> -	fin_freq =3D clk_get_rate(channel->clk);
> +	freq =3D div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
> +	if (freq > ULONG_MAX)
> +		freq =3D ULONG_MAX;
> +
> +	fin_freq =3D clk_round_rate(channel->clk, freq);
>  	if (fin_freq =3D=3D 0) {
>  		dev_err(meson->chip.dev, "invalid source clock frequency\n");
>  		return -EINVAL;

As mentioned previously, we have discussed one optimization for PWM
parent clock calculation. Many modern Amlogic SoCs include an RTC clock
within the clock tree. This clock provides a stable and efficient 32kHz
input for several clock objects that can be inherited through the muxes
from the RTC clock.

In short, we aim to use the RTC clock parent directly for PWM to
generate a 32kHz clock on the PWM lines. Martin has suggested one way to
do so, which is described in [0]. You can also refer to our IRC
discussion in [1].

I would appreciate your thoughts on this. Please let me know what you
think.

[...]

Links:
    [0] https://lore.kernel.org/all/CAFBinCCPf+asVakAxeBqV-jhsZp=3Di2zbShBy=
TCXfYYAQ6cCnHg@mail.gmail.com/
    [1] https://libera.irclog.whitequark.org/linux-amlogic/2023-05-18

--=20
Thank you,
Dmitry=
