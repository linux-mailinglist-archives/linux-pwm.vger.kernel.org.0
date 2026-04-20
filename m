Return-Path: <linux-pwm+bounces-8651-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKs+MtpU5mkDuwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8651-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 18:31:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B42742F92F
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0CBE35D4396
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01C3B7B61;
	Mon, 20 Apr 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="e0yYgZgA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D513C9C4;
	Mon, 20 Apr 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692685; cv=pass; b=DRrwrZas53dwhailMYd/MZMk4gIXoEBT2lHyvz/t11LbN3yxR9cpmYt9vzZCcoWNLnL2qmyZsCDsVVuSsFulrvrC1bRjvXOjhwZeJoy9KRUodZCiZK0/S8gqXdDA7PYus5AiQwSXsedB7SopRvzeorrFE7tqoJfSkFrqtbq7m1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692685; c=relaxed/simple;
	bh=sNIWRbAV3+NPzvh4QoLTVBs2+aGwD7SqO1y5ZMLcUjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uxr6KZwFHa0kpYsKF7XJbda0Wf6HwKAbc47jUDe1hrosAcscua2yC+pNbWn+o1v0GIq2vQ3TuZhq1UluG9jMxWJJ51UdoJwnaxDSHJGylMR/wszbAYEPs42P72c4NvTC7bibEAoyYBmLivoyY2xhFqAfNYjrqGYc0N8GJlLbee0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=e0yYgZgA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776692659; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mkcwrM2zd34qpqDcVR6YMrm683IYTNFwsnrcnqxXc6QfyMACLBM9776F9ysKorGVEK2v5XKxTUkCdbYJ6JhqCK5ofdRtXhBB7y3/inV66/60tpz48tRUzv0+CT35vpax+hIbjgCWck7D/Ykfy+RzBKYTUeW6pruZk5FLjaYBmSI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776692659; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1V3GuJpNnFWJCfMVIGdTdAgiX6h8PD58kcy6YMlRmyg=; 
	b=WB27jklrsxoT2MtVUad/IT9wsRm0zzUx4og1biUR0t3/KOxIYvo9noN98ctcKY1s/WbEIkh5GzANyH9DmMvMmL43k2mAQje762NCtJfK8E2wdIG9MmEksSVV2jK7CSFLtuIiNJXFY/6rEuXZ/vS45r9nL8lo/hadSfpD5z485j4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776692658;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=1V3GuJpNnFWJCfMVIGdTdAgiX6h8PD58kcy6YMlRmyg=;
	b=e0yYgZgAY6nsZsSsAPvVGSdH5P1MJJs7vvPiCsZXWVYhL0E7HOLvx/sKsb+q3sVl
	WgOsEKk9ClrKgrH30latvBAEHpcZ1enwaenfSQnr8RKUtPozJWIb+FrdjyLKRzNrXb/
	AzxJGRCZ3swvSlmNxhyq9Wtin00TR6wgOyfwZUMI=
Received: by mx.zohomail.com with SMTPS id 1776692658154201.29359424090717;
	Mon, 20 Apr 2026 06:44:18 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/5] pwm: Add rockchip PWMv4 driver
Date: Mon, 20 Apr 2026 15:44:13 +0200
Message-ID: <AP7g6gy2QFms8ov59vex7A@collabora.com>
In-Reply-To: <20260420-rk3576-pwm-v4-3-421738c7bf28@collabora.com>
References:
 <20260420-rk3576-pwm-v4-0-421738c7bf28@collabora.com>
 <20260420-rk3576-pwm-v4-3-421738c7bf28@collabora.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-8651-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,collabora.com:dkim,collabora.com:mid]
X-Rspamd-Queue-Id: 4B42742F92F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Monday, 20 April 2026 15:35:21 Central European Summer Time Nicolas Frattaroli wrote:
> The Rockchip RK3576 brings with it a new PWM IP, in downstream code
> referred to as "v4". This new IP is different enough from the previous
> Rockchip IP that I felt it necessary to add a new driver for it, instead
> of shoehorning it in the old one.
> 
> Add this new driver, based on the PWM core's waveform APIs. Its platform
> device is registered by the parent mfpwm driver, from which it also
> receives a little platform data struct, so that mfpwm can guarantee that
> all the platform device drivers spread across different subsystems for
> this specific hardware IP do not interfere with each other.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  MAINTAINERS                            |   2 +
>  drivers/counter/Kconfig                |  11 +
>  drivers/counter/Makefile               |   1 +
>  drivers/counter/rockchip-pwm-capture.c | 307 ++++++++++++++++++++++++++
>  drivers/pwm/Kconfig                    |  11 +
>  drivers/pwm/Makefile                   |   1 +
>  drivers/pwm/pwm-rockchip-v4.c          | 383 +++++++++++++++++++++++++++++++++
>  7 files changed, 716 insertions(+)
> 

Ah jeez, I accidentally squashed the counter driver into this commit.
time to send out a v5, please ignore this.




