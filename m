Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784B863E703
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 02:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiLABRn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 20:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiLABRk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 20:17:40 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64112666;
        Wed, 30 Nov 2022 17:17:36 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=57;SR=0;TI=SMTPD_---0VW5-8b9_1669857445;
Received: from 30.97.48.64(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VW5-8b9_1669857445)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 09:17:29 +0800
Message-ID: <a7e61ce5-b5e6-384a-3c89-ebde63340678@linux.alibaba.com>
Date:   Thu, 1 Dec 2022 09:17:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 01/11] pwm: Make .get_state() callback return an error
 code
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Douglas Anderson <dianders@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Orson Zhai <orsonzhai@gmail.com>,
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
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 11/30/2022 11:21 PM, Uwe Kleine-König wrote:
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index 7004f55bbf11..bda8bc5af976 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -65,8 +65,8 @@ static void sprd_pwm_write(struct sprd_pwm_chip *spc, u32 hwid,
>   	writel_relaxed(val, spc->base + offset);
>   }
>   
> -static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> -			       struct pwm_state *state)
> +static int sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      struct pwm_state *state)
>   {
>   	struct sprd_pwm_chip *spc =
>   		container_of(chip, struct sprd_pwm_chip, chip);
> @@ -83,7 +83,7 @@ static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (ret) {
>   		dev_err(spc->dev, "failed to enable pwm%u clocks\n",
>   			pwm->hwpwm);
> -		return;
> +		return 0;
>   	}
>   
>   	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE);
> @@ -113,6 +113,8 @@ static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   	/* Disable PWM clocks if the PWM channel is not in enable state. */
>   	if (!state->enabled)
>   		clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
> +
> +	return 0;
>   }
>   
>   static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,

For sprd pwm parts:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
