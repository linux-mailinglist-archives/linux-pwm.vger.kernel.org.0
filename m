Return-Path: <linux-pwm+bounces-1058-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3083C39F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 14:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50C01C21373
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C64F8A5;
	Thu, 25 Jan 2024 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hliEhufe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44BD1C02
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189339; cv=none; b=CA22IKnqw2SfM1wNm1XMulCg+NYYylmhmgogCBGdKJCsatLFXm0X03/Geu67dvilOylR/W0z6f+aJr0/MSBu6sYDctxmsQQkQ99AS1VUMlRhuxs5Um+HRHKUJJBFtbPcYFYVbtuFD3vcbNEK7wVIzViTFdx3SOSgrYTe7nho5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189339; c=relaxed/simple;
	bh=LjlUvD38EPPYAi5x37gGk1jRebH/a5Vcfb2HKqmOhtc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AmerO5EPMm4a9dFdyPcrJ83gJy/j0HwY+C9VLmFVO3rn5Vbp+gbT5CqVtgmzdX5WmCnn1O9OmZnT/drUaULgZyQZpg0K2QqRdBIqFGGMquX0cwXPMFyUTCKYBsYO1vzmdLuHXtvr0vjqyIGORsTylTgDzvIAvxsl5NGxLaa8psk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hliEhufe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2FDC433C7;
	Thu, 25 Jan 2024 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189339;
	bh=LjlUvD38EPPYAi5x37gGk1jRebH/a5Vcfb2HKqmOhtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hliEhufer6errtFbw2NKgrDZmUFSLoEYqhUhM4TwWlafgC+3/LkPrB9ezAht2wKWk
	 4QtO9RDfiZTK5KR7Ya0J6qXtYQg/SgzMpX2hKTUoZMOsEx01cQD37JgCvvbsCbJW2S
	 Yjitg1DygwTuJ3TqEFogU+t6ZoKQq1nEQT6a6N16VQy/5vm8j4runI180hiNxOM/Dr
	 ivcYbCMe4cI1++eQzk26ziPsBNH1jL7IgLY+/eYo0SHzdKrq5l11D4SDY2IQZEOJdx
	 T42YF8KKuEabRpmHW+lDvyBDu5fyMZYjhsHAL1pfeEAynK7yA+XGaS5CjophdDgcK0
	 JtCkvIlU1zpgg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Jan 2024 14:28:56 +0100
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 087/111] pwm: sl28cpld: Make use of
 devm_pwmchip_alloc() function
In-Reply-To: <g3nwht566fqcyxyfholgvhc5za2pe4zmhiow5c4fwwkieuwbsr@slxxexro4dsv>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <eba4f163b407831e27d1de769fe3a8ef29ad1f0d.1706182805.git.u.kleine-koenig@pengutronix.de>
 <8c92b4fa9e568f875763c65cdebc925e@kernel.org>
 <g3nwht566fqcyxyfholgvhc5za2pe4zmhiow5c4fwwkieuwbsr@slxxexro4dsv>
Message-ID: <54f93af5837bb07ad5ee2c0aca7a8633@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

>> >  static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct
>> > pwm_chip *chip)
>> >  {
>> > -	return container_of(chip, struct sl28cpld_pwm, chip);
>> > +	return pwmchip_get_drvdata(chip);
>> 
>> This function now seems superfluous. Better use
>> pwmchip_get_drvdata(chip) directly.
>> 
>> If you don't respin or this is too much work, I can
>> send a patch once this is applied.
> 
> I like it keeping around, becuase it returns the right type (instead of
> pwmchip_get_drvdata() which returns void). Also it might be beneficial
> to mark this function with the const attribute. If you want to care for
> this, that would be very welcome.

It's a matter of taste I guess, so I'm fine with either. It's only used 
in
two places. If you return const you can't use it in the probe function. 
And
using pwmchip_get_drvdata() just there is worse.

-michael

