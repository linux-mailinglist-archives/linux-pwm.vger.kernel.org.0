Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC236AD2E5
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Mar 2023 00:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCFXjc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 18:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCFXjb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 18:39:31 -0500
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B03B859
        for <linux-pwm@vger.kernel.org>; Mon,  6 Mar 2023 15:39:30 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 22581700-bc78-11ed-a9de-005056bdf889;
        Tue, 07 Mar 2023 01:39:28 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 7 Mar 2023 01:39:27 +0200
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [DO NOT APPLY PATCH v6 10/13] pinctrl: renesas: rzg2l-poeg:
 output-disable request from GPT when both outputs are low.
Message-ID: <ZAZ5r619EBCmehiI@surfacebook>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
 <20230306090014.128732-11-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306090014.128732-11-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Mon, Mar 06, 2023 at 09:00:11AM +0000, Biju Das kirjoitti:
> This patch adds support fpr output-disable requests from GPT, when both
> outputs are low.
> 
> Added sysfs to enable/disable for configuring GPT output disable request
> when both outputs are low.

...

> +static int rzg2l_poeg_output_disable_both_low(struct rzg2l_poeg_chip *chip,
> +					      bool enable)
> +{
> +	if (enable)
> +		set_bit(RZG2L_GPT_OABLF, chip->gpt_irq);
> +	else
> +		clear_bit(RZG2L_GPT_OABLF, chip->gpt_irq);

JFYI: assign_bit()


> +	rzg2l_gpt_poeg_disable_req_both_low(chip->gpt_dev, chip->index,
> +					    test_bit(RZG2L_GPT_OABLF, chip->gpt_irq));
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


