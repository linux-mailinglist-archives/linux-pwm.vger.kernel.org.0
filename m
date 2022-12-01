Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E088F63F28B
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 15:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiLAOR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 1 Dec 2022 09:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiLAORW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 09:17:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5A5AAFCE3;
        Thu,  1 Dec 2022 06:17:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F40CED1;
        Thu,  1 Dec 2022 06:17:23 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0F8B3F73D;
        Thu,  1 Dec 2022 06:17:09 -0800 (PST)
Date:   Thu, 1 Dec 2022 14:17:07 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>,
        Guenter Roeck <groeck@chromium.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Fabio Estevam <festevam@gmail.com>,
        linux-riscv@lists.infradead.org, linux-leds@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        chrome-platform@lists.linux.dev,
        Florian Fainelli <f.fainelli@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Hammer Hsieh <hammerh0314@gmail.com>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>, linux-sunxi@lists.linux.dev,
        linux-pwm@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, linux-gpio@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-amlogic@lists.infradead.org,
        Benson Leung <bleung@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Scott Branden <sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 01/11] pwm: Make .get_state() callback return an
 error code
Message-ID: <20221201141707.28af0d1d@donnerap.cambridge.arm.com>
In-Reply-To: <20221201131604.beq4l22d42tjy6dm@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
        <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
        <20221201102252.52ace284@donnerap.cambridge.arm.com>
        <20221201131604.beq4l22d42tjy6dm@pengutronix.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 1 Dec 2022 14:16:04 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

Hi Uwe,

> Hello Andre,
> 
> On Thu, Dec 01, 2022 at 10:22:52AM +0000, Andre Przywara wrote:
> > Just one comment: I don't see a sunxi specific patch later in the series,
> > though it seems we have at least one error error exit (see prescaler == 0
> > above). Plus potentially another exit if clk_get_rate() (at the very
> > beginning) fails.
> > Shall I send a patch for that?  
> 
> That would we very welcome. I mentioned that shortly in the cover
> letter, I wasn't entirely sure how to handle that prescaler = 0 case.

Ah right, sorry, I missed that.
So the Allwinner manual somehow marks those prescaler encodings as reserved
or invalid (it's just a "/" in there), and we never set those values in the
driver (there is an explicit check). So it could only be a leftover from
firmware/bootloader, or someone poking at this register behind our back.
I am tempted to just return some -EINVAL. As the current code stands, we
don't manipulate any state flags before that check, so it doesn't
really matter, but would be best practise, at least.

Cheers,
Andre
