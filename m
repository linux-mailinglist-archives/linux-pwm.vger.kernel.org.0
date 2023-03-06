Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26F6AD2DE
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Mar 2023 00:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCFXgG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 18:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFXgF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 18:36:05 -0500
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94FD4DBE0
        for <linux-pwm@vger.kernel.org>; Mon,  6 Mar 2023 15:36:02 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id a5ff45a6-bc77-11ed-abf4-005056bdd08f;
        Tue, 07 Mar 2023 01:36:00 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 7 Mar 2023 01:35:58 +0200
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
 driver support
Message-ID: <ZAZ43tylTNxPIun8@surfacebook>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
 <20230306090014.128732-7-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306090014.128732-7-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Mon, Mar 06, 2023 at 09:00:07AM +0000, Biju Das kirjoitti:
> The output pins of the RZ/G2L general PWM timer (GPT) can be disabled
> by using the port output enabling function for the GPT (POEG).
> 
> Add basic support using s/w control through generic pincontrol sysfs to
> enable/disable output from GPT by registering with RZ/G2L pincontrol
> driver.

You have wrong Subject prefix.

...

> +static void rzg2l_poeg_write(struct rzg2l_poeg_chip *chip, u32 data)
> +{
> +	iowrite32(data, chip->mmio);
> +}
> +
> +static u32 rzg2l_poeg_read(struct rzg2l_poeg_chip *chip)
> +{
> +	return ioread32(chip->mmio);
> +}

Why not regmap MMIO?

...

> +static struct platform_driver rzg2l_poeg_driver = {
> +	.driver = {
> +		.name = "rzg2l-poeg",
> +		.of_match_table = of_match_ptr(rzg2l_poeg_of_table),

Why do you need of_match_ptr()?

> +	},
> +	.probe = rzg2l_poeg_probe,
> +	.remove = rzg2l_poeg_remove,
> +};

-- 
With Best Regards,
Andy Shevchenko


