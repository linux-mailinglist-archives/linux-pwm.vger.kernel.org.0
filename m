Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71CA212BD6
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jul 2020 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgGBSB7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Jul 2020 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgGBSB7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jul 2020 14:01:59 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF21C08C5C1;
        Thu,  2 Jul 2020 11:01:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h23so22015340qtr.0;
        Thu, 02 Jul 2020 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C0N6ebTMTdJ8oNLRoYmc25ksVK6daob4tarO6KDoNoM=;
        b=pZx9UUs/2utdw+dFgEsECyNd+QMs4v4zfhQ4s37feSgKuHvsxSSfFoE1tVQz9h16A6
         UlGSvKN4XxGvaIdzvXRbZe4aUpCghTw2k7mmo5xUPHbJhFfazyhl/AU3LALIqCZxanyT
         lFGP1STuAWF3Yp5NMdu+lzzx5RF+Z7m3hmmk8doAOtTEKTkhQ4kaVF3jcrl4mX2CRAQ7
         4eMhuN0/amQVrVZz9VzknE/+LeVa8TItTtTn4+Zp9GLpd9Locu49GFtmofd0IWfq9+eN
         NoNQ0GVnYyQ/Q/CdOt2cDzXHEY2IThZYfJFHw7HaYhy9XSmT+/tMA1PeiNiCqoZsNXbx
         gXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C0N6ebTMTdJ8oNLRoYmc25ksVK6daob4tarO6KDoNoM=;
        b=J+GRtza+lpSbkTpxieNmiJUuDETEgDZgMCpqJMc5MW8iJE4ohfKRbewap3b8CBHhjR
         xXshezurbyu7Y13EgSBUvoLC1I1IsRKtxSItJ2yOkgkTuYoY5UcZ8kndoMgLoKmQWkZw
         ZAXkh7Aq+am5RLlvOOD3ShIDWfPt0hz1NmTsazmt2fl+oB//hiN4WSOOcKFP0SyR+/F/
         mrUX8qvUpkiPVu27yZqjny6L9fDpXYFWKgo9GnmUKTZoZqcTIFrzmAJI2Rzc+M49UZz9
         /+4mELPcBn92rvWhrhPhN6xJXqLIMfbaJVmwGgguRpa7YlVhEZ4OGrHc9cjCfjXf6XfL
         hYiA==
X-Gm-Message-State: AOAM533zaiX8+PJ5noeNVQpcvvmVtTKuhoMEk5Al+3QZNNaqy9GI8N4p
        KaqP0FjR9bUv39WBxrO0H5EsRvex0jU=
X-Google-Smtp-Source: ABdhPJz/ekMX8q4eOLJuDaTVvmxmrF/8nMPr96S4Z+gyQ8eRjnmAQPDHgXqLXM9JMhNmifTrB/J3OQ==
X-Received: by 2002:ac8:409d:: with SMTP id p29mr32646851qtl.369.1593712917358;
        Thu, 02 Jul 2020 11:01:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::10e2? ([2620:10d:c091:480::1:e927])
        by smtp.gmail.com with ESMTPSA id o10sm8992256qtq.71.2020.07.02.11.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 11:01:56 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v15 3/3] Input: new da7280 haptic driver
To:     Roy Im <roy.im.opensource@diasemi.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <cover.1593435662.git.Roy.Im@diasemi.com>
 <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
Message-ID: <31377d96-3e6d-e7b6-30de-0c7e9e6f9364@gmail.com>
Date:   Thu, 2 Jul 2020 14:01:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 6/29/20 9:01 AM, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> ---
> v15:
> 	- Removed some defines and updated some comments.
> v14:
> 	- Updated pwm related code, alignments and comments.
> v13:
> 	- Updated some conditions in pwm function and alignments.
> v12: No changes.
> v11: 
> 	- Updated the pwm related code, comments and typo.
> v10: 
> 	- Updated the pwm related function and added some comments.
> v9: 
> 	- Removed the header file and put the definitions into the c file.
> 	- Updated the pwm code and error logs with %pE
> v8: 
> 	- Added changes to support FF_PERIODIC/FF_CUSTOM and FF_CONSTANT.
> 	- Updated the dt-related code.
> 	- Removed memless related functions.
> v7: 
> 	- Added more attributes to handle one value per file.
> 	- Replaced and updated the dt-related code and functions called.
> 	- Fixed error/functions.
> v6: No changes.
> v5: Fixed errors in Kconfig file.
> v4: Updated code as dt-bindings are changed.
> v3: No changes.
> v2: Fixed kbuild error/warning
> 
> 
>  drivers/input/misc/Kconfig  |   13 +
>  drivers/input/misc/Makefile |    1 +
>  drivers/input/misc/da7280.c | 1838 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1852 insertions(+)
>  create mode 100644 drivers/input/misc/da7280.c

[snip]

> +static ssize_t
> +patterns_store(struct device *dev,
> +	       struct device_attribute *attr,
> +	       const char *buf,
> +	       size_t count)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	char cmd[MAX_USER_INPUT_LEN];
> +	struct parse_data_t mem;
> +	unsigned int val;
> +	int error;
> +
> +	error = regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
> +	if (error)
> +		return error;
> +
> +	if (count > MAX_USER_INPUT_LEN)
> +		memcpy(cmd, buf, MAX_USER_INPUT_LEN);
> +	else
> +		memcpy(cmd, buf, count);
> +
> +	/* chop of '\n' introduced by echo at the end of the input */
> +	if (cmd[count - 1] == '\n')
> +		cmd[count - 1] = '\0';

You have a potential memory corruption bug here for the case where
 count > MAX_USER_INPUT_LEN. The code correctly clamps the memcpy()
length, but it still is at risk of writing beyond the end of the cmd
buffer when doing the \0 termination.

If you change the code above to say

	if (count > MAX_USER_INPUT_LEN)
		count = MAX_USER_INPUT_LEN
	memcpy(cmd, buf, count);

it should take care of it, and it will also return the actual count
written to the caller.

Cheers,
Jes
