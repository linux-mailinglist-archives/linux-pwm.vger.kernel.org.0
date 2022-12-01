Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6663E7F7
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 03:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiLAClW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 21:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLAClV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 21:41:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC88B92A12;
        Wed, 30 Nov 2022 18:41:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A857B81DCA;
        Thu,  1 Dec 2022 02:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40610C433B5;
        Thu,  1 Dec 2022 02:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669862478;
        bh=oEKpzlNT5/2REuZbJ9nJL8V6rmg/O7EETT/KejHSD8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TH8159Vsmt/10ITe/zhNEMAr0DJShK7lsDLNDN2pIZAVofrn3gusqAdnBs2Qu1cSN
         XCcRLrdtEkYyNEI8SEx6SJRIKDIfDVpLhJHBOP8HqdCgkPwJb3zObY5B7KiqXqV5dU
         YfnDxebKZS69mB2aEBYlCb+U3U7FjKzExxd/CI1VOI09SsnQ0ZvEFiiDbtdXex5IWG
         DBHET0gvgxZrW9389IzXKRfWjYTgc2EntD3p+73FzHGNoSLfnluPj2RUUWlbsAOWtR
         7osJ2K8rd4L8EqCVdL03V/id7vZ6u9INSzhje+ZXfzQM9dAVuQaVr5VyJGNqZHVtHm
         ohZr0MuVoVdZQ==
Date:   Thu, 1 Dec 2022 10:41:06 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
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
Subject: Re: [PATCH v2 01/11] pwm: Make .get_state() callback return an error
 code
Message-ID: <Y4gUQhdeZGm67Js2@google.com>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 30, 2022 at 04:21:38PM +0100, Uwe Kleine-König wrote:
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 7f10f56c3eb6..11684edc0620 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -183,8 +183,8 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return 0;
>  }
>  
> -static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> -				  struct pwm_state *state)
> +static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				 struct pwm_state *state)
>  {
>  	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
>  	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
> @@ -193,7 +193,7 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
>  	if (ret < 0) {
>  		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
> -		return;
> +		return 0;
>  	}
>  
>  	state->enabled = (ret > 0);
> @@ -212,6 +212,8 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  		state->duty_cycle = channel->duty_cycle;
>  	else
>  		state->duty_cycle = ret;
> +
> +	return 0;
>  }

For the cros-ec part:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
