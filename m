Return-Path: <linux-pwm+bounces-5676-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F875A99280
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A11468019
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2898A29C328;
	Wed, 23 Apr 2025 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+W1EKXq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27229B79F;
	Wed, 23 Apr 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421999; cv=none; b=k3FRZRkPaV3BvxO5vrpDQNWDaLXHah/wsneoyEkW1zReGo9pCiAc2ow7jyipSRE2ilcm6HBOWlhqm/535pj2/kOwTF3ZoQzKSA1u2bv7caSLKUQeP4jG4YNbvsM2NpeBZRRY/svovJjyllpgRIPTmY2ifUSAZOd7/j0e+EPzea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421999; c=relaxed/simple;
	bh=byjfADMw7B0iAHcVOEL7w5089D7lAVY4aSDEd/Ylyp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lApVGv4BugCoiOGHVNaxTD7ApjxHwilRRX52HjzCUTTS8XnntZxr4peRrVBNoaiTwL9fnbXRgx/kzL69/GSqkpR9doAuLJjPet2ki7dGklaov/KNuSCxoC7ET/usdFp8wgzJyyIIw0vvKLjRzcZZgAtSxcIHgKfPKnZcGTTzafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+W1EKXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26523C4CEE2;
	Wed, 23 Apr 2025 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421998;
	bh=byjfADMw7B0iAHcVOEL7w5089D7lAVY4aSDEd/Ylyp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+W1EKXqnhCHF1cMXIpgvpu7WEIPHWqZcKd3G5U64jxQc1jkX9B3Ek6iemKhWyaNU
	 flrC+9VLPkCtk3tm8RZHpWqN/udRUf4E4peak68etxvfs1/l5v7/KRgtX3M7C8XtWb
	 8+KIDk4Uqf8sj/U561yolbKjqOVZbxwsDzFKQovubEJbRljsw6qQ37GwbzY8mpfCmy
	 shByIRfT8dNQyqcSDwJLXp4ZrZ0rkP3H2YcXeplLPwcq7NX3U+XZ2OS1QNkaFPjG77
	 FhCAV+Gh6vbEfSWoGvlAK6XjiPKopDKA9JHzwc4Gh0erdTMOkFEpdLD3E0OltqywmY
	 Oc7FmZRhL88AQ==
Date: Wed, 23 Apr 2025 10:26:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
Message-ID: <174542199611.553877.7404234278333094382.robh@kernel.org>
References: <20250418-via_pwm_binding-v2-1-17545f4d719e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-via_pwm_binding-v2-1-17545f4d719e@gmail.com>


On Fri, 18 Apr 2025 18:55:07 +0400, Alexey Charkov wrote:
> Rewrite the textual description for the WonderMedia PWM controller
> as YAML schema, and switch the filename to follow the compatible
> string.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Split the series from v1 into separate bindings patches so as not to
> spam all the subsystems with unrelated changes, per Rob's suggestion
> 
> Changes in v2:
> - reordered nodes in the example same as in properties (thanks Rob)
> 
> Link to v1: https://lore.kernel.org/all/20250416-wmt-updates-v1-5-f9af689cdfc2@gmail.com/
> ---
>  .../devicetree/bindings/pwm/via,vt8500-pwm.yaml    | 43 ++++++++++++++++++++++
>  .../devicetree/bindings/pwm/vt8500-pwm.txt         | 18 ---------
>  MAINTAINERS                                        |  1 +
>  3 files changed, 44 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


