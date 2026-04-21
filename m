Return-Path: <linux-pwm+bounces-8667-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPfRI8ee52nZ+QEAu9opvQ
	(envelope-from <linux-pwm+bounces-8667-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 17:59:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED543D097
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 17:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6015A300D6B7
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FAF347FC4;
	Tue, 21 Apr 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPXgxuER"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD4279DC3;
	Tue, 21 Apr 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787025; cv=none; b=RNhs1IIxnZwZaO5UuOiFeBgTk8pLQeY7a7fPLCrOR8zFcmtBBNfDopWvQRxeo0r5DVJJl83G2ebrINEQOuanbPwUvzsRvt0r0EN1hNebyXTELvG2t6f9nNJ9oQutw/pQ2cSp+TWBX24PtNo8jHV5+6M9Fptkh+P/yV470GasdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787025; c=relaxed/simple;
	bh=L6jvH0KdJ/2HnktukZo98gY67hTXlHukwUOYENICdEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpIX2OrQNd1PZLK9aGtpsBtqbKOR2aG3bqkQq37/K39YZWc5r6Q0kHHmHbMA6MrH3ZECGHEwOocfkefaF/05QmOC/v6tD0W7VdwOIR3megQzYdKWobFpetFC+DDDGkyoMGO7eTQNXpOlFcv90rTkfMTvHZoR0OwLPFpIb3VBzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPXgxuER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06BFC2BCB3;
	Tue, 21 Apr 2026 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776787024;
	bh=L6jvH0KdJ/2HnktukZo98gY67hTXlHukwUOYENICdEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PPXgxuERL7AW+4y8s76kQ7QH7zwyVD6XUCEvLOfHXtqa7ZqZ6db1DGYJ5QMECqtMt
	 qkvfPYlinLnOFalZEzrzh1e1cWV6Z6u1iUjpt/aMYPmPZbxpUknCjTWnBlf0kq1m5B
	 gzbpcwoo9pRWrq6hwwayrxAnWtTUAeCMdM/TtLTaP5b17jCDZA07EKtmxGqcNN+fCc
	 6MjHWP/o/JFOBVDlD8/VNHUm8j3ProgEMufhzRK7c/9VX2Pgp0N674ZzPO1hOzvlkY
	 SsNPZ9anUtD7OF6MVP/UxlJf95iolfVM17lw/WUXzc1ZEfvMUFBoKOgVdhs/ihjVnb
	 z4qcRK0ceAruw==
Date: Tue, 21 Apr 2026 16:56:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones
 <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>, Damon Ding
 <damon.ding@rock-chips.com>, kernel@collabora.com, Jonas Karlman
 <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/6] Add Rockchip RK3576 PWM Support Through MFPWM
Message-ID: <20260421165656.168fe262@jic23-huawei>
In-Reply-To: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8667-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,rock-chips.com,collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org,microchip.com];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02ED543D097
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 15:52:37 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> This series introduces support for some of the functions of the new PWM
> silicon found on Rockchip's RK3576 SoC. Due to the wide range of
> functionalities offered by it, including many parts which this series'
> first iteration does not attempt to implement for now. The drivers are
> modelled as an MFD, with no leakage of the MFD-ness into the binding, as
> it's a Linux implementation detail.

Just thought I'd point out that as this includes the linux-iio
list sashiko took a look at it.  Quite a few things and at least
the first one I looked at was valid (a dereference before a validity
check)

https://sashiko.dev/#/patchset/20260420-rk3576-pwm-v5-0-ae7cfbbe5427%40collabora.com

Whilst this tool does generate some false positives, it also finds
quite a few things it seems us humans fail to spot.

Jonathan

