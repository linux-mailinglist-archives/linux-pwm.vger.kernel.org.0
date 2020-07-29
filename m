Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE6A23278A
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 00:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2WVz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 18:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgG2WVz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jul 2020 18:21:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C578C0619D2
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2020 15:21:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so6604966pfp.7
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2020 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lpiC6AK+sEWlZI+MwabZGhxpD0Px/85s+JfUHli9+h0=;
        b=no3pLtDkQvk988NrIqu55gGquFsxaITQ7UhGPY59vNsdT3/wHypnp0nREjH3tTKKUt
         TLvS8Mh4aRoXGSFmdrZpucz9FOy4DyTMD+0xP8u66YjUeR2i+jRX4ysVIBsZ01jULkBd
         eKPPyJ0AbnKpPZYX5gMKguSUenBGh9JFLQDb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpiC6AK+sEWlZI+MwabZGhxpD0Px/85s+JfUHli9+h0=;
        b=shl5FT4SvRTQZv0Tzxln8pPTa03tax3cSvduYPUmZW5ZvsM0QXLX9475oQlj9/WvMH
         89NhPoAc4mAbkiFCY1n1QUCdHg0Ij5wVhnDLQdwy2NYIDmmvgg4Di8oH893Ls9QOyVUo
         CkcoILMWvnB+U1F39rOT7yRxLtwdoLbtmTTzOkHDncbYYRnzftaUmfQaImlpvtU8kDZa
         yXCEdL40LjKc8Jq5TB1q+xwEhaQRtGpy2hXH5UKYv0/yuhZwUyMV3HAmx/goSka4j9On
         TrorPMjB258e6C9tfvjNtiAfBVWLX+bgd7EoqUlGI+TC1LSRri+I5cqLtgFD1Y0J3ZbX
         b0ig==
X-Gm-Message-State: AOAM531iBo37/ICXcE+Vmfed2RcENQZjXb0AwJJsgc2DtlABJgYPPlcN
        Nbui9nuufhOc0EvvTZnyOlMBfQ==
X-Google-Smtp-Source: ABdhPJz70Chqk2QUSFLgh7Lwy2JGv32EpNClxZsvRzwYv3I6pThsiBrFjg6BexPfgxaoUEbRxP48PA==
X-Received: by 2002:a63:d951:: with SMTP id e17mr30768959pgj.318.1596061314693;
        Wed, 29 Jul 2020 15:21:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id 21sm3502393pfu.124.2020.07.29.15.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:21:53 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:21:50 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 6/6] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
Message-ID: <20200729222150.GA970863@google.com>
References: <20200726220101.29059-1-linux@roeck-us.net>
 <20200726220101.29059-7-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726220101.29059-7-linux@roeck-us.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Guenter,

On Sun, Jul 26, 2020 at 03:01:01PM -0700, Guenter Roeck wrote:
> v3: Use -ENOPROTOOPT for EC_RES_INVALID_VERSION
>     Implement function to convert error codes
> v2: No change
> 
>  drivers/platform/chrome/cros_ec_proto.c | 52 ++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index e5bbec979a2a..a081b8245682 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -15,6 +15,43 @@
>  
>  #define EC_COMMAND_RETRIES	50
>  
> +static const int cros_ec_error_map[] = {
> +	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
> +	[EC_RES_ERROR] = -EIO,
> +	[EC_RES_INVALID_PARAM] = -EINVAL,
> +	[EC_RES_ACCESS_DENIED] = -EACCES,
> +	[EC_RES_INVALID_RESPONSE] = -EPROTO,
> +	[EC_RES_INVALID_VERSION] = -ENOPROTOOPT,
> +	[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
> +	[EC_RES_IN_PROGRESS] = -EINPROGRESS,
> +	[EC_RES_UNAVAILABLE] = -ENODATA,
> +	[EC_RES_TIMEOUT] = -ETIMEDOUT,
> +	[EC_RES_OVERFLOW] = -EOVERFLOW,
> +	[EC_RES_INVALID_HEADER] = -EBADR,
> +	[EC_RES_REQUEST_TRUNCATED] = -EBADR,
> +	[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
> +	[EC_RES_BUS_ERROR] = -EFAULT,
> +	[EC_RES_BUSY] = -EBUSY,
> +	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
> +	[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
> +	[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
> +	[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
> +};

Sorry I didn't pay attention to this earlier, but is there any
programmatic way to ensure that we don't have unexpected holes here? If
we do (e.g., we add new error codes, but they aren't contiguous for
whatever reasons), then those will get treated as "success" with your
current patch.

I say "unexpected" hole, because EC_RES_SUCCESS (0) is an expected hole.

> +
> +static int cros_ec_map_error(uint32_t result)
> +{
> +	int ret = 0;
> +
> +	if (result != EC_RES_SUCCESS) {
> +		if (result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[result])
> +			ret = cros_ec_error_map[result];

^^ Maybe we want to double check 'ret != 0'? Or maybe

			ret = cros_ec_error_map[result];
			if (!ret) {
				ret = -EPROTO;
				dev_err(..., "Unexpected EC result code %d\n", result);
			}

? Could even be WARN_ON(), since this would be an actionable programming
error, not exactly an external factor. Or maybe I'm being paranoid, and
future programmers are perfect.

Otherwise:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> +		else
> +			ret = -EPROTO;
> +	}
> +
> +	return ret;
> +}
> +
>  static int prepare_packet(struct cros_ec_device *ec_dev,
>  			  struct cros_ec_command *msg)
>  {
