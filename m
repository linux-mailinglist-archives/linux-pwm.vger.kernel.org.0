Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC919DA909
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393790AbfJQJsL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 05:48:11 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:44382 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfJQJsL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Oct 2019 05:48:11 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 361F5A4D02;
        Thu, 17 Oct 2019 11:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1571305688;
        bh=eQCarCOp3f/nSqL9V45D90qKfVpFX2IgEmm6tHGaB+4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eGnaUyai1q/cVnWvAKyPX0U39wGAh5sALY+umUGE5zV7ptro0/0CF4eChkRW3sNht
         r9IKVgffvNejQMbjfqPGwJCDFAyl/zpy/c3RPn69eZsKGE5Gu02Oz/Z6KxtNC+TRpG
         dmPa8e9nmnv4ykPUOOEsFXJtcz4jRL0OZr9kV09U=
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
Date:   Thu, 17 Oct 2019 11:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17. 10. 19 10:10, Uwe Kleine-König wrote:
> A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> pwm_get_state() return the last implemented state")) changed the
> semantic of pwm_get_state() and disclosed an (as it seems) common
> problem in lowlevel PWM drivers. By not relying on the period and duty
> cycle being retrievable from a disabled PWM this type of problem is
> worked around.
> 
> Apart from this issue only calling the pwm_get_state/pwm_apply_state
> combo once is also more effective.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> There are now two reports about 01ccf903edd6 breaking a backlight. As
> far as I understand the problem this is a combination of the backend pwm
> driver yielding surprising results and the pwm-bl driver doing things
> more complicated than necessary.
> 
> So I guess this patch works around these problems. Still it would be
> interesting to find out the details in the imx driver that triggers the
> problem. So Adam, can you please instrument the pwm-imx27 driver to
> print *state at the beginning of pwm_imx27_apply() and the end of
> pwm_imx27_get_state() and provide the results?
> 
> Note I only compile tested this change.

Hi Uwe,
I was just about to respond to the "pwm_bl on i.MX6Q broken on 5.4-RC1+"
thread that I have a similar problem when you submitted this patch.

So here are my few cents:

My setup is as follows:
  - imx6dl-yapp4-draco with i.MX6Solo
  - backlight is controlled with inverted PWM signal
  - max brightness level = 32, default brightness level set to 32 in DT.

1. Almost correct backlight behavior before 01ccf903edd6 ("pwm: Let
    pwm_get_state() return the last implemented state):

  - System boots to userspace and backlight is enabled all the time from
    power up.

    $ dmesg | grep state
    [    1.763381] get state end: -1811360608, enabled: 0
    [    4.939658] apply state start: -1797997308, enabled: 0
    [    4.946437] apply state start: -1797997436, enabled: 0
    [    4.952936] apply state start: -1797997420, enabled: 1

  - $ cat brightness
    32

  - $ echo 32 > brightness # nothing happens, max. brightness

  - $ echo 1 > brightness # backlight goes down to lowest level
    [   59.876561] apply state start: -1711276636, enabled: 1

  - $ echo 0 > brightness # backlight goes up to max. level, this is
                          # problem of the inverted PWM on i.MX we attempted
                          # to solve some time ago.
    [  102.456582] apply state start: -1711276700, enabled: 0
   
2. Backlight behavior on v5.4-rc3:

  - System boots to userspace and backlight is enabled all the time from
    power up.

  - $ dmesg | grep state
    [    1.773056] get state end: -1811319520, enabled: 0
    [    4.994003] apply state start: -1797948160, enabled: 0
    [    5.000617] get state end: -1811319520, enabled: 0
    [    5.006950] apply state start: -1797948292, enabled: 0
    [    5.013446] get state end: -1811319520, enabled: 0
    [    5.019602] apply state start: -1797948276, enabled: 1
    [    5.027536] get state end: -1811319520, enabled: 1

  - $ cat brightness
    32

  - $ echo 32 > brightness # backlight goes down
    [  189.956756] apply state start: -1711923804, enabled: 1
    [  189.965907] get state end: -1811319520, enabled: 1

  - $ echo 1 > brightness # backlight goes up to high level
    [  464.136633] apply state start: -1711923804, enabled: 1
    [  464.145625] get state end: -1811319520, enabled: 1

  - $ echo 0 > brightness # backlight goes up to highest level
    [  527.136640] apply state start: -1711923868, enabled: 0
    [  527.145538] get state end: -1811319520, enabled: 0

So the behavior is clearly inverted to how it worked prior to 01ccf903edd6
with the weird exception that the initial brightness level 32 is
not applied.

3. Backlight behavior on v5.4-rc3 + this patch:

  - System boots with backlight enabled. In the middle of kernel boot
    backlight is disabled.

  - $ dmesg | grep state
    [    1.773233] get state end: -1811319520, enabled: 0
    [    5.002753] apply state start: -1797948160, enabled: 0
    [    5.009397] get state end: -1811319520, enabled: 0
    [    5.015652] apply state start: -1797948276, enabled: 1
    [    5.026682] get state end: -1811319520, enabled: 1

  - $ cat brightness
    32

  - $ echo 32 > brightness # nothing happens, backlight is down

  - $ echo 1 > brightness # backlight goes to high level
    [  305.377274] apply state start: -1711915596, enabled: 1
    [  305.386374] get state end: -1811319520, enabled: 1

  - $ echo 0 > brightness # backlight goes to max brightness
    [  362.637297] apply state start: -1711915596, enabled: 0
    [  362.646325] get state end: -1811319520, enabled: 0

Same behavior as (2) but the default state from DT is apparently applied.

I only did this experiments. I did not delve into the code to track what is
going on in there yet.

Hopefully this helps you a bit and feel free to request other experiments,
Michal

>   drivers/video/backlight/pwm_bl.c | 34 +++++++++++---------------------
>   1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 746eebc411df..ddebd62b3978 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -42,10 +42,8 @@ struct pwm_bl_data {
>   
>   static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>   {
> -	struct pwm_state state;
>   	int err;
>   
> -	pwm_get_state(pb->pwm, &state);
>   	if (pb->enabled)
>   		return;
>   
> @@ -53,9 +51,6 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>   	if (err < 0)
>   		dev_err(pb->dev, "failed to enable power supply\n");
>   
> -	state.enabled = true;
> -	pwm_apply_state(pb->pwm, &state);
> -
>   	if (pb->post_pwm_on_delay)
>   		msleep(pb->post_pwm_on_delay);
>   
> @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>   
>   static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>   {
> -	struct pwm_state state;
> -
> -	pwm_get_state(pb->pwm, &state);
> -	if (!pb->enabled)
> -		return;
> -
>   	if (pb->enable_gpio)
>   		gpiod_set_value_cansleep(pb->enable_gpio, 0);
>   
>   	if (pb->pwm_off_delay)
>   		msleep(pb->pwm_off_delay);
>   
> -	state.enabled = false;
> -	state.duty_cycle = 0;
> -	pwm_apply_state(pb->pwm, &state);
> -
>   	regulator_disable(pb->power_supply);
>   	pb->enabled = false;
>   }
>   
> -static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
> +static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness, struct pwm_state *state)
>   {
>   	unsigned int lth = pb->lth_brightness;
> -	struct pwm_state state;
>   	u64 duty_cycle;
>   
> -	pwm_get_state(pb->pwm, &state);
> -
>   	if (pb->levels)
>   		duty_cycle = pb->levels[brightness];
>   	else
>   		duty_cycle = brightness;
>   
> -	duty_cycle *= state.period - lth;
> +	duty_cycle *= state->period - lth;
>   	do_div(duty_cycle, pb->scale);
>   
>   	return duty_cycle + lth;
> @@ -122,12 +104,20 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>   
>   	if (brightness > 0) {
>   		pwm_get_state(pb->pwm, &state);
> -		state.duty_cycle = compute_duty_cycle(pb, brightness);
> +		state.duty_cycle = compute_duty_cycle(pb, brightness, &state);
> +		state.enabled = true;
>   		pwm_apply_state(pb->pwm, &state);
> +
>   		pwm_backlight_power_on(pb);
> -	} else
> +	} else {
>   		pwm_backlight_power_off(pb);
>   
> +		pwm_get_state(pb->pwm, &state);
> +		state.enabled = false;
> +		state.duty_cycle = 0;
> +		pwm_apply_state(pb->pwm, &state);
> +	}
> +
>   	if (pb->notify_after)
>   		pb->notify_after(pb->dev, brightness);
>   
> 

