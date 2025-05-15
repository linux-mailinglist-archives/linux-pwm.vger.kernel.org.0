Return-Path: <linux-pwm+bounces-5989-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA36AB7A88
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 02:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8E11B63DFC
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 00:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F4BF9EC;
	Thu, 15 May 2025 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giLgSzaB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A333E1;
	Thu, 15 May 2025 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268515; cv=none; b=XWv0EoKmgWrvcUW4tLSZQRC14RUDbRPwb567mFmK+xIJeDVAtFvC7MtIXB2lgMDNLzMCHbkFRV8lJYuPrjGO/OGC3pi5sC8fpCcqRnio8EsYG1ANhi9vmbP2JW/E2+RkcPEDMqqMfyI59sNmKOpQVxyE2ay8jCO7PDrMbk4FZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268515; c=relaxed/simple;
	bh=iZxb2jBSDnEKEW1l8qaYvCVJkwZAk7SAXLmlCJt7lxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwdv8wj5gjZsQ8yAXdMV33Xltrjwec94lvxEvIUdFjHlsjAScxjaXCD/+js5yzbLLzZ7EFkAtNTvntxfH0NBfZ40i8Ul7YuO1Mx4OC0bgX4i8GGHfGmPVmZN4sf+BXok39r6yc72c2e24sUiycyVT4o8hdvdhWDrgQcbYXB57No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giLgSzaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D6AC4CEE3;
	Thu, 15 May 2025 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747268514;
	bh=iZxb2jBSDnEKEW1l8qaYvCVJkwZAk7SAXLmlCJt7lxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=giLgSzaBsrTSQmdRgRpUok5qVyhLCBeiG1y7Q+F9QOxdTyOHZSGu3wBBs5jdwmRQd
	 Y/dEjgXDvwC9CKdCgvIwpnWGjd2lySS6TaDlfUZoknEMD5nBADd8fMm0OWh/9GZMr3
	 iGncaotXhTW+6uDLr/woGh7OgWk4uDrKRUhY7gkhOW+51suO/j2DAR9hjm1wOXubmb
	 DcC4Mb7wl/hrkhz9FTBcg0+CEFl022ZyX3G92G1cCXSJP6LiIGb80NkfAkeFbwUK4a
	 yjHIb1AAzbqy+v/TYQ308zyorknRpWQqpR5F6WVe5/Ap3cOvld6RUk3efsGxU5fBdD
	 BNpRuEqQCkY8Q==
From: William Breathitt Gray <wbg@kernel.org>
To: lee@kernel.org,
	ukleinek@kernel.org,
	alexandre.torgue@foss.st.com,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jic23@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: (subset) [PATCH v3 3/8] counter: stm32-timer-cnt: add support for stm32mp25
Date: Thu, 15 May 2025 09:21:44 +0900
Message-ID: <174726846872.375413.17945727550032496363.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250110091922.980627-4-fabrice.gasnier@foss.st.com>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com> <20250110091922.980627-4-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=630; i=wbg@kernel.org; h=from:subject:message-id; bh=OdGDVpoycRi9OLgJVrxFO0kSREUlcdbL9tUWTQlQjY0=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBmqxk0rK0SetGYe2/NbVNbk7vGd194rcnVfNZvmKK+fq uxzofRMRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRrT2MDDMPdm3oZe7d43yL P/HuJlNRHv4LndeCOZdZimyW5v6+4gAjw4K73xwSPxzacXX6f0v3gChdga36XCHf71mdSLv1dbV /LDcA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Fri, 10 Jan 2025 10:19:17 +0100, Fabrice Gasnier wrote:
> Add support for STM32MP25 SoC. There are new counter modes that may be
> implemented in later. Still, use newly introduced compatible to handle
> this new HW variant and avoid being blocked with existing compatible
> in SoC dtsi file. Modes supported currently still remains compatible.
> New timer 20 has encoder capability, add it to the list.
> 
> 
> [...]

Applied, thanks!

[3/8] counter: stm32-timer-cnt: add support for stm32mp25
      commit: ace2cd11a27231efcb8a116a597edab2eef34957

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

