Return-Path: <linux-pwm+bounces-7578-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2602C282CA
	for <lists+linux-pwm@lfdr.de>; Sat, 01 Nov 2025 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A22E3BA2F7
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Nov 2025 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C7025A35E;
	Sat,  1 Nov 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQxafMp2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671A2571DD;
	Sat,  1 Nov 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014552; cv=none; b=FFo6cC6OCu2/WSf1UwkYbMbrfPZWhaj8iix+7F5nqhTspWxeGOouIvyKSLetJaj9zw5in0698kspy2inJrbZ7hgd+GQaNA02n1jhf5NaIJIpODPlZipRNQaZT86h/J75G9UXmEeyBSwqepcr1LcPJq0o9JcFor7kQ86HCNxUfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014552; c=relaxed/simple;
	bh=mOOA+C1R49pgXQracXNdHSHDAKyKnXuVu8Nt5iEqIfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOGv5NLbsGNlQts+2Y5GbItXN/oD1btgHfyruwvMkEJGiNrsqRWXoLmC59Z9hvQYdYJhxjGoLntzvmhKofIui6ujeRzzn8mgnN90sjn22Ie7vSwnzcmLO3JVHg4/km/n2G06PXV94mVLPGHsldft+hZfjfELpWDYOKoZw5wFRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQxafMp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9A1C4CEF1;
	Sat,  1 Nov 2025 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762014551;
	bh=mOOA+C1R49pgXQracXNdHSHDAKyKnXuVu8Nt5iEqIfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BQxafMp292Sny2DJvfsRfD7LhATGsqCEfaNqeuS3nkX6fiGe9K4VSs3PErA1U+Qwe
	 bQaJjq8HoT3eYDlg9HlkLZkQGv9wFrZyIfibLEwtMMgaUXcV48dyrh0OvHFxSvx2kH
	 3GQxMudvC85ucDa7qDMg4fz0qLmSlNvhRmZWBJ9CN7zZ82zIqQxVP3cfvzSlhaDdVs
	 2775tQVZalnjFTHwZXq+U2k8zgSZ9D6Q6DIDIsZrrtt7zbXa9xTuYSCigvUBi0HgU2
	 Cgyajanlb/PE/oUxRiGAzE5shY/3J4pwOd4dvL8NIYwUosAhwpGoiTrkH4FgqRygoe
	 hM6GjFdp4rDVA==
Date: Sat, 1 Nov 2025 16:28:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jack Hsu <jh.hsu@mediatek.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, srini@kernel.org,
 ukleinek@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 daniel.lezcano@linaro.org, tglx@linutronix.de, chunfeng.yun@mediatek.com,
 wim@linux-watchdog.org, linux@roeck-us.net, sean.wang@mediatek.com,
 zhiyong.tao@mediatek.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 02/11] dt-bindings: iio: adc: Support MediaTek MT8189
 evb board auxadc
Message-ID: <20251101162855.303b3e5e@jic23-huawei>
In-Reply-To: <20251030-deftly-lent-0588c4e910b1@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
	<20251030134541.784011-3-jh.hsu@mediatek.com>
	<20251030-deftly-lent-0588c4e910b1@spud>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 19:30:39 +0000
Conor Dooley <conor@kernel.org> wrote:

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Applied.

