Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7174563EF33
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 12:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiLALRW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 06:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiLALQu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 06:16:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC122B2B56;
        Thu,  1 Dec 2022 03:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669893141; x=1701429141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oqwp1prmygFipaS7+KydzauQtsm23Yws4T/2+sBogyI=;
  b=v8G6tiH0dwPUW+p3XYtyTbv4LmVyKSzwGtkk1RtBOdAilgPS2Wy+VgJg
   lpoywgE0PGMFQ0sIy2J4PlDpkk9wYmDxktF5KOGQ9FlpCvxmM8v89BVSS
   nA/cgKVNF0yxuef2XOn/TyQpHAKLAqU0IQ1IF3/Hb2x7S1NIEvFx3diW0
   5EFHKlbH0LVTk0EaGakRzXxYNzpYl7osHO9HhQFry9YEFCY/QXqAIotvW
   Ag7l5Te+CbqBtd5j0i1FtkWIqGL754C+bvSM6BwcyoX95SpEAnACVwpsV
   FBx0lLQCLu+BLGxGHyQvG+Ibo/I7Fp6niz9vd4YgILK8m0KqzVNFJZ3Cr
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="202161679"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Dec 2022 04:12:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Dec 2022 04:12:19 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Dec 2022 04:12:10 -0700
Date:   Thu, 1 Dec 2022 11:11:51 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Douglas Anderson" <dianders@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "Broadcom internal kernel review list" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        <linux-pwm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-sunxi@lists.linux.dev>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v2 00/11] pwm: Allow .get_state to fail
Message-ID: <Y4iL9xf5bJM5pyeR@wendy>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hey Uwe!

On Wed, Nov 30, 2022 at 04:21:37PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> I forgot about this series and was remembered when I talked to Conor
> Dooley about how .get_state() should behave in an error case.

In the context of "my" driver, get_state() the proposal was to fail with
-ETIMEDOUT rather than block a caller, potentially, for seconds or
report a potentially "random" state.

Specifically, values writen to the registers that control the PWM duty
cycle are not visible to the cpu until the changes have propagated to
the waveform at the start of a new period.
The timeout would occur if the bit that signifies that the "shadow
registers" contain a value which has not yet propagated. This bit is
per PWM "controller" and not per PWM channel.

Returning from apply() without waiting, possibly for seconds, for the
writes to become visible could cause get_state() to see anything between
the new and old states, inclusive!

If anyone cares at all, the discussion is here:
https://lore.kernel.org/linux-pwm/20221110093512.333881-1-conor.dooley@microchip.com/T/#m800eeabad29067940a5684e54106fd0bb7261944

> In v1 Thierry had the concern:
> 
> | That raises the question about what to do in these cases. If we return
> | an error, that could potentially throw off consumers. So perhaps the
> | closest would be to return a disabled PWM?
> | Or perhaps it'd be up to the
> | consumer to provide some fallback configuration for invalidly configured
> | or unconfigured PWMs.
> 
> .get_state() is only called in pwm_device_request on a pwm_state that a
> consumer might see. Before my series a consumer might have seen a
> partial modified pwm_state (because .get_state() might have modified
> .period, then stumbled and returned silently). The last patch ensures
> that this partial modification isn't given out to the consumer. Instead
> they now see the same as if .get_state wasn't implemented at all.

Getting the same thing as if get_state() did not exist seems
preferable to me in this context than "lying" and pretending that a PWM
is disabled or potentially inconsistent reports from get_state() that I
mentioned above.

TL;DR, I quite like the ability to return an error and not mislead the
caller.

Thanks for sending a v2 of this so quickly :)
Conor.

