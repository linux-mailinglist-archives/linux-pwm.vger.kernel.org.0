Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2567A1509D7
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2020 16:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBCPdX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Feb 2020 10:33:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53804 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCPdX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Feb 2020 10:33:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9A0FC28F6C9
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 13/17] pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
 <20200130203106.201894-14-pmalani@chromium.org>
Message-ID: <5d7cbb93-dfa0-11d3-1374-2e4044ead524@collabora.com>
Date:   Mon, 3 Feb 2020 16:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200130203106.201894-14-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 30/1/20 21:31, Prashant Malani wrote:
> Convert one existing usage of cros_ec_cmd_xfer_status() to
> cros_ec_send_cmd_msg(), which accomplishes the same thing but also does
> the EC message struct setup,and is defined in platform/chrome and is
> accessible by other modules.
> 
> For the other usage, switch it to using cros_ec_cmd_xfer(), since the
> calling functions rely on the result field of the struct cros_ec_command
> struct that is used.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/pwm/pwm-cros-ec.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 89497448d21775..8bf610a6529e7e 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -32,25 +32,14 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
>  
>  static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
>  {
> -	struct {
> -		struct cros_ec_command msg;
> -		struct ec_params_pwm_set_duty params;
> -	} __packed buf;
> -	struct ec_params_pwm_set_duty *params = &buf.params;
> -	struct cros_ec_command *msg = &buf.msg;
> -
> -	memset(&buf, 0, sizeof(buf));
> +	struct ec_params_pwm_set_duty params = {0};
>  
> -	msg->version = 0;
> -	msg->command = EC_CMD_PWM_SET_DUTY;
> -	msg->insize = 0;
> -	msg->outsize = sizeof(*params);
> -
> -	params->duty = duty;
> -	params->pwm_type = EC_PWM_TYPE_GENERIC;
> -	params->index = index;
> +	params.duty = duty;
> +	params.pwm_type = EC_PWM_TYPE_GENERIC;
> +	params.index = index;
>  
> -	return cros_ec_cmd_xfer_status(ec, msg);
> +	return cros_ec_send_cmd_msg(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
> +				    sizeof(params), NULL, 0);
>  }
>  
>  static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
> @@ -78,11 +67,13 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
>  	params->pwm_type = EC_PWM_TYPE_GENERIC;
>  	params->index = index;
>  
> -	ret = cros_ec_cmd_xfer_status(ec, msg);
> +	ret = cros_ec_cmd_xfer(ec, msg);

Why? There is a good reason we introduced the cros_ec_cmd_xfer_status.

IMO the purpose of introduce the new wrapper only makes sense if we can cover
_all_ the cases, so we can remove cros_ec_cmd_xfer_status and make
cros_ec_cmd_xfer private to cros_ec_proto.

Is not possible to use the new wrapper here?

>  	if (result)
>  		*result = msg->result;

Hmm, I see, that's the problem ...

This driver will need a bit of rework but I think could be possible to use the
wrapper.

>  	if (ret < 0)
>  		return ret;
> +	else if (msg->result != EC_RES_SUCCESS)
> +		return -EPROTO;
>  
>  	return resp->duty;
>  }
> 
