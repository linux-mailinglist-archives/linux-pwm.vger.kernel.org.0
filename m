Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA336061C
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhDOJrI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 05:47:08 -0400
Received: from smtp106.ord1d.emailsrvr.com ([184.106.54.106]:54508 "EHLO
        smtp106.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhDOJrI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Apr 2021 05:47:08 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2021 05:47:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1618479564;
        bh=sdlyLj6d3Jci9vL6n3SdCe0jc0zXhGFiWjpE4Y8KIzU=;
        h=Subject:To:From:Date:From;
        b=R5Pt5Hn2Hqqi8pXd+WnWja8/DOi4OhXCXPZtEDSwlJ2uXqL1sPGkZOb+czdsXOnyX
         QfLAkHIyxHqBH+ar5hBAa6sYqAd5G8CN2lX7e7DyzC+cz1nKr+l/qn26Ux5GpC5qf+
         AC1bSo/ucMyXToTyGQlLZq+w+rgOtRmaEXCtAeAI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 09B9EE01DE;
        Thu, 15 Apr 2021 05:39:22 -0400 (EDT)
Subject: Re: [PATCH 55/57] staging: comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-56-lee.jones@linaro.org>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <fd880e8e-a5fc-67ef-6ba4-f59592dee71d@mev.co.uk>
Date:   Thu, 15 Apr 2021 10:39:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414181129.1628598-56-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Classification-ID: 57b37ea6-05b9-4e64-8263-c6605ab5306c-1-1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 14/04/2021 19:11, Lee Jones wrote:
> ... and mark it as __maybe_unused since not all users of the
> header file reference it.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: ‘range_ni_E_ao_ext’ defined but not used [-Wunused-const-variable=]
> 
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: "David A. Schleef" <ds@schleef.org>
> Cc: Mori Hess <fmhess@users.sourceforge.net>
> Cc: Truxton Fulton <trux@truxton.com>
> Cc: linux-staging@lists.linux.dev
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/staging/comedi/drivers/ni_mio_common.c | 9 ---------
>   drivers/staging/comedi/drivers/ni_stc.h        | 9 ++++++++-
>   2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/staging/comedi/drivers/ni_mio_common.c
> index 4f80a4991f953..37615b4e2c10d 100644
> --- a/drivers/staging/comedi/drivers/ni_mio_common.c
> +++ b/drivers/staging/comedi/drivers/ni_mio_common.c
> @@ -160,15 +160,6 @@ static const struct comedi_lrange range_ni_M_ai_628x = {
>   	}
>   };
>   
> -static const struct comedi_lrange range_ni_E_ao_ext = {
> -	4, {
> -		BIP_RANGE(10),
> -		UNI_RANGE(10),
> -		RANGE_ext(-1, 1),
> -		RANGE_ext(0, 1)
> -	}
> -};
> -
>   static const struct comedi_lrange *const ni_range_lkup[] = {
>   	[ai_gain_16] = &range_ni_E_ai,
>   	[ai_gain_8] = &range_ni_E_ai_limited,
> diff --git a/drivers/staging/comedi/drivers/ni_stc.h b/drivers/staging/comedi/drivers/ni_stc.h
> index fbc0b753a0f59..0822e65f709dd 100644
> --- a/drivers/staging/comedi/drivers/ni_stc.h
> +++ b/drivers/staging/comedi/drivers/ni_stc.h
> @@ -1137,6 +1137,13 @@ struct ni_private {
>   	u8 rgout0_usage;
>   };
>   
> -static const struct comedi_lrange range_ni_E_ao_ext;
> +static const struct comedi_lrange __maybe_unused range_ni_E_ao_ext = {
> +	4, {
> +		BIP_RANGE(10),
> +		UNI_RANGE(10),
> +		RANGE_ext(-1, 1),
> +		RANGE_ext(0, 1)
> +	}
> +};
>   
>   #endif /* _COMEDI_NI_STC_H */
> 

I think it is better where it is for now with its fellow struct 
comedi_lrange variables, but feel free to mark it as __maybe_unused.

(Really, the #include "ni_mio_common.c" mess needs sorting out sometime.)

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
