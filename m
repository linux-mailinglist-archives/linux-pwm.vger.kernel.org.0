Return-Path: <linux-pwm+bounces-5109-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD224A502A0
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 15:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5708F3B37EF
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A4248890;
	Wed,  5 Mar 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ3ePrW2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFD204C35;
	Wed,  5 Mar 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185957; cv=none; b=pZeYJVSS7xu6Vt2dtvu9vOLrDmYrwKqmEMjmRJck7DGnFQzFOK+jjP6tcgPWGjLqZJR5Ur1c6qrRCcJclvX1oozhYRflVK/TRGqk9TPuBuog0d0Xm3VRzVzuSEdqBgxCvUUX0zOyHtpnK79hSFoQuoeew0eglQkIhO6qCtw/57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185957; c=relaxed/simple;
	bh=9XvWDEUMq04erEjB0dy5I+sM2+nP0CgSu78Orb4kT3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TK6yFtz1uvp/fPxO7OVjj3dcm4nubm/eOJqc/ztjpLJJtyxrGekbPDVGut+1rbhmXm1XD+rsruvV/YY2Evi4IIIAKMrrEKXMVUcRsYXwDwX+whzJyM44jKj4YE1y6HhPTGjYTrui9nMclMqa24db8UBVA8VmCeXvMS/7FfWj4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ3ePrW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBCFC4CED1;
	Wed,  5 Mar 2025 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741185956;
	bh=9XvWDEUMq04erEjB0dy5I+sM2+nP0CgSu78Orb4kT3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KQ3ePrW2UjFrYDF+Nbz2H3HSxpA0DCwhiDatnIrcXGue6ZTEjg8Vwvs5VqZicRTeH
	 9ySwgtQtV7csxOgt1PE4Vk+kSPHcbEwk9oJ+gV5z2je1h2Mem4X1AZuFL1OCeiQ6fh
	 3qfTCjdDetgm65gqGNTFcAmgHlblBKRaPoGulb523SAIdHE7sDu1jO90F4tyVHkIZo
	 EzAOmhx75/VVf/CpEjZAGmnixgzgDrMc1u8RRQ/O5n6v0hFDHTkq36ZuLCU3GE1icB
	 4UwZIg566Y6ErRW1xz3uoW8P/KuVJCSNmRrTOrMrBSgUVAa8hcR0LoJQzpVpZHLzB2
	 ox9WyH5+ctLXw==
Date: Wed, 5 Mar 2025 14:45:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
 <wbg@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v3 3/8] iio: trigger: stm32-lptimer: add support for
 stm32mp25
Message-ID: <20250305144539.54a75689@jic23-huawei>
In-Reply-To: <20250305094935.595667-4-fabrice.gasnier@foss.st.com>
References: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
	<20250305094935.595667-4-fabrice.gasnier@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 10:49:30 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> From: Olivier Moysan <olivier.moysan@foss.st.com>
>=20
> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
> this new HW variant. Add new trigger definitions that can be used by the
> stm32 analog-to-digital converter. Use compatible data to identify them.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Hi. Oops I replied to v1 without looking for other versions.
=46rom a quick glance feedback still applies here.


