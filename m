Return-Path: <linux-pwm+bounces-6248-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D4EACF832
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 21:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BCE3A9DA3
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16989276025;
	Thu,  5 Jun 2025 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcSc1ZQs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF513D53B;
	Thu,  5 Jun 2025 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152582; cv=none; b=bXLtgMZusDbLe6vGy3kADYEqrt4SLkIeVyju3Q4rGn+dSnvrnUZNsvgThjOVBh7C8TFqHHZodYt+fVeLaDfsKbRMxaE8gMjeVp41uCuL1WeKVx3LDCUkwxmfY3ARQqPUcGHDHGTboNwM+DklpJ5jfLYJ195WIv8wqZa+DmWAArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152582; c=relaxed/simple;
	bh=/s6AKwVp+jfuqmc/thf1fMH97ajTpSTCwvgVwHwdnMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qstxAqPHztXJ8DFKZOFK/9i6mYTSmVE9JfZB7O71xuyCC1CRK2P9Dqfuo+QWHkOpdCU/YLgnBocMOzeBtt+157kXgDStVi+V6Qxr5Oi56/5JvmpMnBSysyQEVA4LoMEIa0ddq8STK3owNpKqftyggz1JRdzmnWmrxHE2rmMsAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcSc1ZQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F4DC4CEE7;
	Thu,  5 Jun 2025 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749152581;
	bh=/s6AKwVp+jfuqmc/thf1fMH97ajTpSTCwvgVwHwdnMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcSc1ZQsQC9l7VAD5/n8c0yIE8YRElS8UYwsS2mqB1BDRwNQz/L3eJmqo0kT0jvcf
	 iZgC3BdPZN1IZmASZ4gbqL9tVrbu1ZXvsDTUmDcgbQtCHSUHax/1FnuyT9kSCCQYXJ
	 RGQi79NzzZMOKwD2L9xXQRK1WOTsxA8vIa2WP3OAq07hctQLFejVW10ahE43CAEcyh
	 6Tny0zMG2xSNja4ZMaA824PtQApsj5rSmB0yrf3KH5FqM9VdhZetqYgobDnkAkUtNx
	 TmOsSvs/D0S2Htbvu3DkHOBzhsyQiaBAtzvIuKzw6ekDADDt9EFbRNGMxMhIydBYdE
	 nZI8Ryvjn2TSA==
Date: Thu, 5 Jun 2025 14:42:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells = <3>
Message-ID: <174915257650.3119744.13253716639828217509.robh@kernel.org>
References: <20250527205823.377785-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250527205823.377785-2-u.kleine-koenig@baylibre.com>


On Tue, 27 May 2025 22:58:22 +0200, Uwe Kleine-König wrote:
> With the goal to unify all PWM bindings to use #pwm-cells = <3> update
> the renesas,rz-mtu3 binding accordingly. Keep <2> documented as a
> deprecated value at least until the in-tree device trees are fixed
> accordingly.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  .../devicetree/bindings/timer/renesas,rz-mtu3.yaml         | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


