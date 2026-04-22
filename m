Return-Path: <linux-pwm+bounces-8670-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMwnBB6z6GmIOwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8670-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2026 13:38:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 806144457FB
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2026 13:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E7A53043D20
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2026 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D91B3D16F4;
	Wed, 22 Apr 2026 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ksp9vjk/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350163D16E9;
	Wed, 22 Apr 2026 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857524; cv=pass; b=l/tI/nZgqDIbYvaJaCgwVMP9fFk+m7hILnCbIgszEDT9NuUwnu28pDYd7zj/qWtLB2O65hE1WoW0R/5JuWmnhx+5GnVsWJxjJwBpTu4jo3VN1HTitMqKJI0MMcxyk1mv/E3Ze7zvnzznhQ4TvHY/koS8Ws6gq7QRwbRpME311M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857524; c=relaxed/simple;
	bh=73d6xedjq/TrIi2MX7wO7DWMhYuG5U97itdIBmvEPts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISBF7QTCijTaK72+3adcfrfrJLFiNc0PMljUw9o9hpqUccxxvn5lRRIxhSmSRdRCvGK/saWp/YOX0A3S9Io/kTuAja+nvrJc5kdj7imhzcHXDYBi/onDFoT5KJxWXGFjyEEMhtF/s0+8j2cHBVnJUSskeQSdLM1GHrbDn7XE5Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Ksp9vjk/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776857483; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MimHX1btavL7aACKXbdbvysrgAWp7/h5gFGy0xHKQ/Du6bp0FIO7a0p9vtNaUdkOBhW2/75EBsNoXOj3Io204G1/L5hjkdnDKU/xpnaSOCPKZpFuXkOCXyh6OIcCU7tRAiZ6/XnYAvKteHNXCr1SKTpqwrYEwkm0P5QVS9IGBvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776857483; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IKttHRgNksRfLVo0DvEk3tP1JHxpksMPWqcmRaCbT+I=; 
	b=hPmNYIiolteG3jpCgdNyLhqBseheqVImT3aQo7VSf3ifAMe0hRCvmjcW4aHj0wRdINyu3V09bcVvxgYTCoQhHT67qP2v0H1dUePSPyYyyF/Lpoi9eUaTx2XGs6lDT7ips0weDGhWx1euRa3LOU6XJLwPYlgG5CErywroJr3jI8k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776857483;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=IKttHRgNksRfLVo0DvEk3tP1JHxpksMPWqcmRaCbT+I=;
	b=Ksp9vjk/uOy3DfAI6qlRjw4lwueKETLEFdNgnDwMmrGjLB3l5DNYzPKkVRpmGmI3
	SvPNgAdV2bFvWOmI2esOq6C98aHebioFu+d4fAjUswv5b3Z1WDw9tU3P1FSPRJ07zsh
	aF5AsAg8GR4EePlaQM/B82/lHqEHQXf8qtzBtQIM=
Received: by mx.zohomail.com with SMTPS id 1776857481494503.366495114184;
	Wed, 22 Apr 2026 04:31:21 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/6] Add Rockchip RK3576 PWM Support Through MFPWM
Date: Wed, 22 Apr 2026 13:31:14 +0200
Message-ID: <dB_doorKQsK5TdJ40Tv8Lw@collabora.com>
In-Reply-To: <20260421165656.168fe262@jic23-huawei>
References:
 <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260421165656.168fe262@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-8670-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,rock-chips.com,collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org,microchip.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,collabora.com:dkim,collabora.com:mid]
X-Rspamd-Queue-Id: 806144457FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tuesday, 21 April 2026 17:56:56 Central European Summer Time Jonathan Cameron wrote:
> On Mon, 20 Apr 2026 15:52:37 +0200
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> 
> > This series introduces support for some of the functions of the new PWM
> > silicon found on Rockchip's RK3576 SoC. Due to the wide range of
> > functionalities offered by it, including many parts which this series'
> > first iteration does not attempt to implement for now. The drivers are
> > modelled as an MFD, with no leakage of the MFD-ness into the binding, as
> > it's a Linux implementation detail.
> 
> Just thought I'd point out that as this includes the linux-iio
> list sashiko took a look at it.  Quite a few things and at least
> the first one I looked at was valid (a dereference before a validity
> check)
> 
> https://sashiko.dev/#/patchset/20260420-rk3576-pwm-v5-0-ae7cfbbe5427%40collabora.com
> 
> Whilst this tool does generate some false positives, it also finds
> quite a few things it seems us humans fail to spot.
> 
> Jonathan
> 

While I'm not entirely opposed to this, I do think reviews should happen
on-list when possible. Sashiko is a Google service, so it has about a 50%
chance of still being around in 2 years time. One of the benefits of the
kernel development workflow is that discussion going back decades is still
accessible.

The reason why these aren't posted to list goes into the other thing
that I currently am not stoked about, which is that I'd have to act as
a filter for a Bring-Your-Own-Brain noise generator to pick out the
parts that aren't convincing lies.



