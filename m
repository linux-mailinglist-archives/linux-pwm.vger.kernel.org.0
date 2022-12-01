Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40963F199
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 14:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiLAN3Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 08:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiLAN3Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 08:29:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC008A9CFB;
        Thu,  1 Dec 2022 05:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669901362; x=1701437362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uzYyfpe5ovcmHtziruShrAihFDRO3ojyXNM6UnYgYzM=;
  b=tmHPurYXVLVpFYdLIqgvPMlbkSnnU1cf61uor8EnedPd6W6EiRJ2/9L2
   9LYu66/FnTpawxLZnYi2WzvCsOGfqeX9ruSm2407lvDaG6+BoIL7cvnoW
   j3ag1ouTyhU2k0qPX43lzIKbY0jDEBbV6JUldQ0trVVpFBqBD5PcGGiH9
   ehspGwxj8pjoNHlohJCQrR5qDO0lWu9bVWCvBXQuxgw3tBY1DT6+ZfMRZ
   rshnmCO43TlbTZNjAnXrIdJniAsnLRFj2Idg4Zh7I0GAYn9HMnhHZ4uXq
   juXqDDqIcDdjlUgIjc0OKzTvwwZ2lC+E+kp4N+8lBZf58cwmfjUbX16FQ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="125998122"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Dec 2022 06:29:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Dec 2022 06:29:09 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Dec 2022 06:29:01 -0700
Date:   Thu, 1 Dec 2022 13:28:42 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Guenter Roeck" <groeck@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        <linux-riscv@lists.infradead.org>, <linux-leds@vger.kernel.org>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        <chrome-platform@lists.linux.dev>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Sean Anderson" <sean.anderson@seco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        <linux-rockchip@lists.infradead.org>, Chen-Yu Tsai <wens@csie.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Broadcom internal kernel review list" 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        <linux-sunxi@lists.linux.dev>, <linux-pwm@vger.kernel.org>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Stephen Boyd" <swboyd@chromium.org>, <linux-gpio@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Michael Walle" <michael@walle.cc>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 00/11] pwm: Allow .get_state to fail
Message-ID: <Y4isCnKP9pTacksl@wendy>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <Y4iL9xf5bJM5pyeR@wendy>
 <20221201131907.bmrenldnua7uaeab@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221201131907.bmrenldnua7uaeab@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 01, 2022 at 02:19:07PM +0100, Uwe Kleine-König wrote:
> Hello Conor,
> 
> On Thu, Dec 01, 2022 at 11:11:51AM +0000, Conor Dooley wrote:
> > TL;DR, I quite like the ability to return an error and not mislead the
> > caller.
> 
> Is this an Ack?

It is if you want it to be! I didn't really feel qualified to do so
which is why I gave some context etc.

I did check out the callsites for the non-void returning op, and it
looked good to me, so sure, why not:

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

