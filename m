Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9489338B04A
	for <lists+linux-pwm@lfdr.de>; Thu, 20 May 2021 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhETNq2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 May 2021 09:46:28 -0400
Received: from smtp125.ord1d.emailsrvr.com ([184.106.54.125]:50956 "EHLO
        smtp125.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233593AbhETNq1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 May 2021 09:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1621518305;
        bh=0J2cZCgGNeHKd40qC7x/GP/F3O7N6Ym4nlc3fVWljsk=;
        h=Subject:To:From:Date:From;
        b=hLrUMydJEIxEsyLrEqXEEz+iV49F9ERbq6oMouUeZdzqa0+MW8vHrGSycb3CqFE7n
         PkTKnYqOGK70+D/hoi347Vf5nXXvOzvdOZ0qzhNNqNmqj27or02BysnSBI8r3ljjST
         6Qx+u3Rirtzh6+G20cYBizKUzdOjrULWqpLnWG28=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 11B8F401E4;
        Thu, 20 May 2021 09:45:03 -0400 (EDT)
Subject: Re: [PATCH 5/6] comedi: drivers: ni_mio_common: Move
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
References: <20210520122538.3470259-1-lee.jones@linaro.org>
 <20210520122538.3470259-6-lee.jones@linaro.org>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <c69d39a0-bf9e-857d-93ba-73e2884fa4ad@mev.co.uk>
Date:   Thu, 20 May 2021 14:45:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520122538.3470259-6-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Classification-ID: acb7c74a-4ef3-49ec-81ee-04773f38be7d-1-1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 20/05/2021 13:25, Lee Jones wrote:
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
>   drivers/comedi/drivers/ni_mio_common.c | 9 ---------
>   drivers/comedi/drivers/ni_stc.h        | 9 ++++++++-
>   2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
> index 4f80a4991f953..37615b4e2c10d 100644
> --- a/drivers/comedi/drivers/ni_mio_common.c
> +++ b/drivers/comedi/drivers/ni_mio_common.c
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
> diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_stc.h
> index fbc0b753a0f59..0822e65f709dd 100644
> --- a/drivers/comedi/drivers/ni_stc.h
> +++ b/drivers/comedi/drivers/ni_stc.h
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

The "ni_stc.h" header is also included by "ni_mio_cs.c" which doesn't 
need `range_ni_E_ao_ext` (admittedly, it was already pulling in a 
"tentative" definition of the variable).

Thinking about it, I think it's probably better to move 
`range_ni_E_ao_ext` from "ni_mio_common.c" into *both* "ni_atmio.c" and 
"ni_pcimio.c" (I think we can live with the small amount of 
duplication), and to remove the tentative definition from "ni_stc.h".

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
