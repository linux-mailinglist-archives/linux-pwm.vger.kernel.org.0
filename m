Return-Path: <linux-pwm+bounces-1710-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542C871BE5
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 11:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3566F1F25024
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 10:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D141C67;
	Tue,  5 Mar 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFTxySPR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630B11198;
	Tue,  5 Mar 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634625; cv=none; b=oz7dpDbTBY/gzwsVd2j+yWW5I7T4b9KEAPrG53F5s53uPF0qRgX2/oIQPCACKq04YM04n6V2FmZI3qk7IYHYDYKf+lUJiR4AUhXAjuPRQjsTGGcz2GvjBxxwuIctgET63oGNzDC+4Jn2eU+jgRlKkHe9x5Qo7/lmOUNsLvQ/ZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634625; c=relaxed/simple;
	bh=NFHYZPCn1iRdzYwgW5HIMl0T/4npS5nF2/vEjh+JuOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NCGqzquQeztemzsLXLknPR8S3aHznQ71VPT/f3WPE0Q99TUEiMEQDISU64eEg0iBDI4jwV7xIL8tsB9puaYJ/Dr7GJY1Lwb+hxHodvuAgq0RtRhTUSy51pKcrlTomwGq1hv/Ldi20BAjsjRxFEa/Oqi53EaCUk2u2nvmtn2Pzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFTxySPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA5DC433C7;
	Tue,  5 Mar 2024 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634625;
	bh=NFHYZPCn1iRdzYwgW5HIMl0T/4npS5nF2/vEjh+JuOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZFTxySPRZx59XD3uzj19WgnlvWjAgsAma51hEVMdNa1Slm5uVyfvgeeghyi6U/ewx
	 nYHtHCFdJ7KfvL0M471EaXSHXN3G8cXXzkL73uuky/BkJEjwZ033+xNMz9DwjrSaiM
	 iMYCJCPsV+5mBBsu0Kz1CbGEL7PEeIsRI+OSB4qayHDrNp26r2FXnuK+h0Hpy090dG
	 +EUczuIuHBwuUO/1fH8Z/u8K9ZpK5aAU3OUx4JbgnZgwRNiMEtiFyRo1HqaXHPbkfn
	 dFTmQ/yQd0qUjctrtxumpJPJHbKUK2ochzOrndK0Gzlpd18jkpewFO/JyAHXnPvUer
	 RA2EPQpyTikCA==
From: Lee Jones <lee@kernel.org>
To: andy@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
 deller@gmx.de, robin@protonic.nl, javierm@redhat.com, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
In-Reply-To: <20240304163220.19144-1-tzimmermann@suse.de>
References: <20240304163220.19144-1-tzimmermann@suse.de>
Subject: Re: [PATCH v3 00/10] backlight: Replace struct fb_info in
 interfaces
Message-Id: <170963462254.80615.15102290140369290410.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 10:30:22 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 04 Mar 2024 17:29:45 +0100, Thomas Zimmermann wrote:
> Backlight drivers implement struct backlight_ops.check_fb, which
> uses struct fb_info in its interface. Replace the callback with one
> that does not use fb_info.
> 
> In DRM, we have several drivers that implement backlight support. By
> including <linux/backlight.h> these drivers depend on <linux/fb.h>.
> At the same time, fbdev is deprecated for new drivers and likely to
> be replaced on many systems.
> 
> [...]

Applied, thanks!

[01/10] backlight: Match backlight device against struct fb_info.bl_dev
        commit: 67716b34e1be2beb7464f9b9d0b47b2cc7dbc208
[02/10] auxdisplay/ht16k33: Remove struct backlight_ops.check_fb
        commit: 747554336b46a26fcdf47e2e48044c7e175b6a5f
[03/10] hid/hid-picolcd: Fix initialization order
        commit: d55b578e3b0cd6abdc52e2c34d88dd3487bb10a2
[04/10] hid/hid-picolcd: Remove struct backlight_ops.check_fb
        commit: 09ca774d2e87f9b086b23354b1605709fb50205f
[05/10] backlight/aat2870-backlight: Remove struct backlight.check_fb
        commit: 61e837e975abcb4d278c3427d927e1cbaaed0090
[06/10] backlight/pwm-backlight: Remove struct backlight_ops.check_fb
        commit: 9c2be31d2951c8dce90950db000c095330406f94
[07/10] fbdev/sh_mobile_lcdc_fb: Remove struct backlight_ops.check_fb
        commit: a2a8fbdb54a78fd18850cd0b74b465657ffb1e0c
[08/10] fbdev/ssd1307fb: Init backlight before registering framebuffer
        commit: 5500326bd33e52230866f50770ca822ce400a4ab
[09/10] fbdev/ssd1307fb: Remove struct backlight_ops.check_fb
        commit: d1b82cc44fd8be4013538992814c45f0e55c02b4
[10/10] backlight: Add controls_device callback to struct backlight_ops
        commit: 7e508af663e20e9e40003bb30e06b926c754159b

--
Lee Jones [李琼斯]


