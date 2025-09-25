Return-Path: <linux-pwm+bounces-7352-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC7B9F12F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Sep 2025 14:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89800165F93
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Sep 2025 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2B2E92B7;
	Thu, 25 Sep 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imDAzvPI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E21114;
	Thu, 25 Sep 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801768; cv=none; b=aJ+6CN0E//WmvXwo1L4gVj7EDeBIPoZU6O7oTKZZT78TyNYIdoezumhBWGpDjb6thkRm/JnGM3/URcQPybSduPjqw3bxEOt3r0M9uVIgJ6A6Q7dxhozshGyVbD9FqXNesINAAPFgbYL/dBaIqI3R4EEiy9F5Q704GtpyFJTbUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801768; c=relaxed/simple;
	bh=tuE6xflWcaKmFJf9w+lu6caRXbN9sSiQ2vruiq3nDlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UDwRdsmO5jenE1hwTqjrFpBMjpDY9ecxXnKlPcf3JMGLoiKFPCXTtAgEiYJUxQbHhS8wVSK97X/zl0s9AKIOemzh+qkolKFYOqtLv0kQhhNEUTqiA1TQz51Bx3HXZKVpIe9rbjLeYe+c8esCziGF5/KhSyY8M+AmMOkooymj3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imDAzvPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08781C4CEF0;
	Thu, 25 Sep 2025 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758801768;
	bh=tuE6xflWcaKmFJf9w+lu6caRXbN9sSiQ2vruiq3nDlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=imDAzvPIZpb/SDOQqQFIbV1Lz4Osr21Qi3ZwUjiC/tAwLnypuE3DIEp/MW2x88O+n
	 Kkzqvepy61elkOvFfWCf0oNDOL7uzdcApfOvICwEfTQGfj3chHdO+lh+z5iyA894cW
	 pjHvdXVXYRMybKxPQdYXRCWMwz6ZNsgL7M13G32fNUMsX0DxIzNkQheOMOVAEzi8nu
	 l7hDqoJlyAX7rUZEvxKQgmjxt5jsvJyx+mQSk69J8VB7GdXLYcGKPD4GvngdESDWdp
	 O2XJDckPmLOyY6Wn+dSIX6j2BPssWwm9ZpUJ+AIU77NVjLH+w+T553QYVblm3bZfyX
	 Ava5+/3OSwu/Q==
From: Lee Jones <lee@kernel.org>
To: andreas@kemnade.info, Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, tony@atomide.com, robh@kernel.org, 
 conor+dt@kernel.org, ukleinek@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-omap@vger.kernel.org
In-Reply-To: <20250914192516.164629-2-jihed.chaibi.dev@gmail.com>
References: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
 <20250914192516.164629-2-jihed.chaibi.dev@gmail.com>
Subject: Re: (subset) [PATCH v8 1/3] dt-bindings: mfd: twl: Add missing
 sub-nodes for TWL4030 & TWL603x
Message-Id: <175880176577.636753.11273046302452228673.b4-ty@kernel.org>
Date: Thu, 25 Sep 2025 13:02:45 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-459a0

On Sun, 14 Sep 2025 21:25:14 +0200, Jihed Chaibi wrote:
> Update the main TI TWL-family binding to be self-contained and to fix
> pre-existing validation errors.
> 
> To ensure future patches are bisectable, child nodes whose bindings
> are in other patches (audio, keypad, usb, etc.) are now defined using
> a flexible 'additionalProperties: true' pattern. This removes hard
> dependencies between the MFD and subsystem bindings.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
      commit: 44232889ce7769dd957972df773b6bd639400b41

--
Lee Jones [李琼斯]


