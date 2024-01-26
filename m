Return-Path: <linux-pwm+bounces-1088-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3591A83D5BE
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 10:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C1028A0C3
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F51E14AA7;
	Fri, 26 Jan 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgRIW2oj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69214AA2
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jan 2024 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256918; cv=none; b=DDGVd3/NkN6GXtNt3HWsfXeKT3ElX79Lh368TyLEM9USZBBTG+kcm1Fmll/z1QA8A7kVHcL+2ioEug8VsRauELwR0dH34bUk4P2bocSX3ZPOKk8k3AZ+MKW/zf9Xm1cVZp2cdi4iQ09HXy3+e69CC4sMq4l+/vNV7w7nl8QZ5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256918; c=relaxed/simple;
	bh=b8RjFzCXtogQPwFhj8x0PhXxvVhO7AOW2xn9VtQNREM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JI0NMUURD6jCs2wNIiu5fqs7YNMCKXG/FwZCIUkOS9kWubEvyQnZon5LwJn62jVfWNj/eMkeZUtJLQTSCfSCDbtzgLjayGWdN4ZZ7YY1eV4hfi9js1UZQEpFLnstEPV39gNU9omHB2Qt8s5q0/L+imXIIAvUrIX2no8a8RGl094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgRIW2oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAACC433C7;
	Fri, 26 Jan 2024 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706256917;
	bh=b8RjFzCXtogQPwFhj8x0PhXxvVhO7AOW2xn9VtQNREM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mgRIW2ojAoBK9joEehzhK3T9jpqeFupGGtvhAVrJJf5G9T8XhKJIVoB1ecjSIes/V
	 iUN5RA+H3lYwUY1pw6UBiNRaj+uBY+LR83lwfJb3SRWV26xGvByDfXN0Nuv3qVbD2V
	 ijeh/VSvxtli95y2F7SIvwKCKmdT82TjBtn3DcwmV9PDcz8p49PDPRBWJYnXo+N5w+
	 5r9H0vcCJcrU6daj6tTL0bwcXNoDyL8UGUHErOSX7qid32VXw/L3i9oAhYDJhNsFPl
	 EeqVLCU4J4Tt4OhjyOrUnlAlWVky92T2rDBGbsAy0yqsX7p+nybLOipLv+2gBpasbg
	 zl6/2CqWx0Umg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jan 2024 09:15:08 +0100
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 087/111] pwm: sl28cpld: Make use of
 devm_pwmchip_alloc() function
In-Reply-To: <tdnopqe6tgk4lyelaevyrsklwlpciwqjseqdn22yq56k6yhcfn@jy467apaymil>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <eba4f163b407831e27d1de769fe3a8ef29ad1f0d.1706182805.git.u.kleine-koenig@pengutronix.de>
 <8c92b4fa9e568f875763c65cdebc925e@kernel.org>
 <g3nwht566fqcyxyfholgvhc5za2pe4zmhiow5c4fwwkieuwbsr@slxxexro4dsv>
 <54f93af5837bb07ad5ee2c0aca7a8633@kernel.org>
 <tdnopqe6tgk4lyelaevyrsklwlpciwqjseqdn22yq56k6yhcfn@jy467apaymil>
Message-ID: <482b1d8e7d1620cce6076329de0efa65@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

> My guess is, we're not talking about the same thing. I consider:
> 
> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
> index 934378d6a002..1dcdcdd03787 100644
> --- a/drivers/pwm/pwm-sl28cpld.c
> +++ b/drivers/pwm/pwm-sl28cpld.c
> @@ -85,6 +85,7 @@ struct sl28cpld_pwm {
>  	u32 offset;
>  };
> 
> +static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct 
> pwm_chip *chip) __attribute__((const));
>  static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct 
> pwm_chip *chip)

You're right. I thought you mean returing pointer to a const struct.

Anyway, it might be correct in the pwm case, because the data is 
contained
within the pwm struct (at least for now), so for any given pointer the
returned value is just pointer + offset. But there is a huge warning 
that
const shouldn't be used with pointers (or rather to look at the data the
pointer points to). Therefore, I'm not sure this is a good idea.

OTOH I've never used this attribute, so I might be wrong. The kernel
doesn't seem to use it very often.

-michael

