Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03811EC519
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2020 00:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFBWey (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 18:34:54 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:6126 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbgFBWey (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 18:34:54 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Jun 2020 15:34:53 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 02 Jun 2020 15:34:53 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 1888A4D82; Tue,  2 Jun 2020 15:34:53 -0700 (PDT)
Date:   Tue, 2 Jun 2020 15:34:53 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v16 06/11] pwm: imx27: Use 64-bit division macro
Message-ID: <20200602223452.GA470@codeaurora.org>
References: <cover.1591135774.git.gurus@codeaurora.org>
 <fcc92b6499e8200ad6b02ab13b38e4d310afe0ba.1591135774.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc92b6499e8200ad6b02ab13b38e4d310afe0ba.1591135774.git.gurus@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jun 02, 2020 at 03:31:11PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_state.period's
> datatype to u64, prepare for this transition by using
> DIV_ROUND_UP_ULL to handle a 64-bit dividend.
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-imx27.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 732a6f3..c50d453 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -202,7 +202,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
>  	sr = readl(imx->mmio_base + MX3_PWMSR);
>  	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
>  	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
> -		period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
> +		period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm),
>  					 NSEC_PER_MSEC);
>  		msleep(period_ms);
>  
> -- 

Please disregard this patch, it was sent by mistake. The correct patch
is [1].

[1]: https://lore.kernel.org/lkml/bb43ff8ad9e0b9884722d85e51c8fdb3ef4154d1.1591136989.git.gurus@codeaurora.org/

Thank you.

Guru Das.
