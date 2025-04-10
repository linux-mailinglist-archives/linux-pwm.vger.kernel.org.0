Return-Path: <linux-pwm+bounces-5441-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413CA83D98
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678ED1B849CD
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 08:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD820E71C;
	Thu, 10 Apr 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5Fcyh2F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6A20E33A
	for <linux-pwm@vger.kernel.org>; Thu, 10 Apr 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275235; cv=none; b=Q1FZSix5rfTnie+yQiNqdrpM5n8uXV3WydyUvb2X46E02UH6jjCkaLBmk3JD6ib2lYerDG3FmTi2YFhcAfT5oQaCKpwbI+8MdocyMGwMF0slmu/mcemb9lMnIVU5knk3eLnbWv+3zZ4j1SkOid1Rp19NpTIfkxPevigWcr4JtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275235; c=relaxed/simple;
	bh=Lbwv7j8DSMSNeMI8ylAo/sckl3dee6Phcsfyk5W+5Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmfhw1cI2AAlci3UKcsEOQ1orbGzqab5CLAWd6HYwddYqec8jxTZu29DSMgNuc1FeIVpPu+hfvuFFYsn4kv5E4zQJD4tJ4F8JKZOiZJNgJje9w3U3521TwcrDBvigDL1zXfAPCCf0tCKHCqcn29RkbianElmsiYjhrotBxKI0FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J5Fcyh2F; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso4055885e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 10 Apr 2025 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744275232; x=1744880032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xSOEQOWHOcYTxIkI87OrM9efMYozO+iVfaQ3HZrqW8U=;
        b=J5Fcyh2Fc/H29O2myvInjNO1SGjT6yFGHWaT9BYHSJxfwcyrSS3WLNZA8bm6lHvb9K
         hMqDhs4O2sh24AS3Alak1Zn0Plw+ccGOMSNyEB9J6RB7SofhwTfXBos9UHvCoqkKrkxe
         EV1GLf2xg7u5J3RBD6tox1nZ+/qL73RqjVBQQShUIZ1wbUca+/eg2q5BWZxu2uZmnKIq
         AryT6wtywvhhYtZMa6oENhPGPKa/P0nV8Fvaw+JqXl8ouQ5z6jM6eFNS5js5eCom9Sq3
         9vRjEJDSGWLfdaN20xN7lx0C0P2SdbrvGI/2Zn7czyOXrUbirIhNYX3k8t9S5nuO2MCb
         oxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275232; x=1744880032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSOEQOWHOcYTxIkI87OrM9efMYozO+iVfaQ3HZrqW8U=;
        b=b31jcIJa88HV/7E6D5QykNbU5ThA9XxdUs3cmDin2y4+kk1VM0IS9CgI4SzgvMluTM
         XmOswb1IRHLben/M2jc155mTdJ5ftUjPgsQMS/KS8VI4aKHmah8FL74fV2F5y32hW9me
         f7f+Thf2D+ey00nawXamrwk01teSE15MidOJczCuupMnoD9iGEP58URo2LOtETYF+G/3
         ZflpfERPbik/2broY/VpKr10RkjwIC+tU1RvsMQSG2x/q4Kxq9RTrOog63p5L1HLnxk5
         WL9bN2SfMM6z8a73cv26rAc65hIz0pNolAT+IM03ZjEOQCMbHIyyOi6rItc8DjNWGluy
         tUGw==
X-Forwarded-Encrypted: i=1; AJvYcCUXmwihVfrDyPK+WkcPJL0a1nClfiXNqdm6o1K7OP2GbKj9HtWShY8TlvUtzG+pKiN5bklwrmvr3yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpbnf5NEL5IVCs5njZqzMMhsmHAVYc0vJy/P+KtuEOdstr6G6k
	n3ZjEFEV1qyuEGMl0apIBwxtIVOt08Z4pBMP46W9sKbI8TG3G7JjF2dXn2kieiO8mBb3SoKemcp
	3
X-Gm-Gg: ASbGncubmKSudwXmV79h6wYpT60A8AbJPsnSyMRSDHHZZOjwbjKFzU6lloBIZB22MeK
	iCwhnmJcSTrYngdd3ICrWd2YPMwYDubousB8fnfeiAkOl2T6aZ7UpSmnPOmHYSB5Ev8pJxRmQIB
	2x7fvkeJJMfIxy/0pkLC15Tgi66m2UKc9LT3uRRE3UAyGgtboX3yfCtbyEuuIfEoHtzc0H5o79y
	Trxhu6Jf8BH6ZSGMCq3l/0GQQ2Kfal9DOv95EzlU/QP5DleDPeRiN8GUDxU2O3LlBtbv6KMEza8
	Pepl8Q+GCJyr/n7y5mc/HKvfqsSQlzAdsk3+Q+olMvUX2A==
X-Google-Smtp-Source: AGHT+IFN603LuCYIC+l2fCiWCgkc1vCOIvDxY88pOKA0Me0WPSmPtMaDy+n5BF4X2DfRyKTc+N7n5g==
X-Received: by 2002:a05:600c:34c7:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43f2d7e9318mr21861205e9.18.1744275232088;
        Thu, 10 Apr 2025 01:53:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d893776dfsm4182455f8f.33.2025.04.10.01.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:53:51 -0700 (PDT)
Date: Thu, 10 Apr 2025 11:53:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org
Subject: Re: [bug report] pwm: Add Loongson PWM controller support
Message-ID: <910ccc00-2279-467a-88ea-03168fec1034@stanley.mountain>
References: <44f3c764-8b65-49a9-b3ad-797e9fbb96f5@stanley.mountain>
 <bg4zper5r7aj7tae4qo34f6hzrjwrrmyjfqmv6gwy6mrj6hvgx@6vubp6v3yitr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bg4zper5r7aj7tae4qo34f6hzrjwrrmyjfqmv6gwy6mrj6hvgx@6vubp6v3yitr>

On Thu, Apr 10, 2025 at 09:47:31AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Apr 09, 2025 at 01:59:59PM +0300, Dan Carpenter wrote:
> > Commit 322fc380cea1 ("pwm: Add Loongson PWM controller support") from
> > Mar 31, 2025 (linux-next), leads to the following Smatch static
> > checker warning:
> > 
> > drivers/pwm/pwm-loongson.c:126 pwm_loongson_config() warn: impossible condition '(duty > (~0)) => (0-u32max > u32max)'
> > drivers/pwm/pwm-loongson.c:131 pwm_loongson_config() warn: impossible condition '(period > (~0)) => (0-u32max > u32max)'
> > 
> > drivers/pwm/pwm-loongson.c
> >     118 static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >     119                                u64 duty_ns, u64 period_ns)
> >     120 {
> >     121         u32 duty, period;
> >                 ^^^^^^^^^^^^^^^^^
> > 
> >     122         struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> >     123 
> >     124         /* duty = duty_ns * ddata->clk_rate / NSEC_PER_SEC */
> >     125         duty = mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_SEC);
> > --> 126         if (duty > U32_MAX)
> >     127                 duty = U32_MAX;
> >                 ^^^^^^^^^^^^^^^^^^^^^^
> > 
> >     128 
> >     129         /* period = period_ns * ddata->clk_rate / NSEC_PER_SEC */
> >     130         period = mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC);
> >     131         if (period > U32_MAX)
> >     132                 period = U32_MAX;
> > 
> > These limits are unnecessary and potentially confusing.
> 
> The intention to check for an overflow however is correct. Something
> like
> 

Yeah, your solution works.  Another option would be to declare duty and
period as u64 types.

regards,
dan carpenter


