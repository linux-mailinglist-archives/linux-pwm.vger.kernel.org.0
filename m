Return-Path: <linux-pwm+bounces-1807-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28460885D15
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Mar 2024 17:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B2F2818FC
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Mar 2024 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA212BF26;
	Thu, 21 Mar 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6zvo+K0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BFC76052;
	Thu, 21 Mar 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037570; cv=none; b=WkJzC+oTWNHd6dtipmN8BUPIZwYc15fD8e7qgsnbzHNcPMSUEpY0lSE5NMCw8Z5svDgEVCAT/JhUZwHRToEfKUDlKm4AN/1YHdO5Sq00FgjZnWOprz6pON0lBX+S5KhfNWoUB1nC9KkIs+5I+geIxLaSTGyRpfKCN8KMBHxgg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037570; c=relaxed/simple;
	bh=6NPow3V/0Wt+lAq16jw5Ca4MIxYnRXOGaHoibGDMLas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qLeX+xgLplH61z1lH4uf+KDQO4AWMiY9g/9QM4fepDJ+ie39OEB4l19SZ54htyXl18CTEAQrwTAFYdlfcRWmrC06VUBpTARJ50W6VOLeQobWvHTVgnG/UdLxuzbPWkeLcUu/5M8AkxkmnZeByZbdo0NnyojulkhEE7ILoAKvkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6zvo+K0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D381C43390;
	Thu, 21 Mar 2024 16:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711037569;
	bh=6NPow3V/0Wt+lAq16jw5Ca4MIxYnRXOGaHoibGDMLas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o6zvo+K0z+pthjZ1rv6n6C6QkLMLKSKM2m1xQZmtsoZLeZe26l7Xg0v6zgdenfeST
	 +FiZQeUsfbyMDZk/sAsYu0fS01skXvmUXQW9YJ4ho8Any/kw2K+DRzw0BSeAVIkQ97
	 YUcDnn95rFH+LWuaqmd5033Gi6VrGLFYJ1VBXfsqF53sbn8p7yttSksCBesdctu46T
	 nE3GZik+UOEfPMxXitw8aRBOeCOHxcbvWLRzNg8bQgZI3MIQkK1B8axnS2JqCLn0Cu
	 H9WvM3ahpkpNOCxYW0/m39nDz/knHPt9vsEn2eXyM46wpzxmx2bduXUikq0vVeUdtC
	 ZCs9gbiaK3K2w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, andy@kernel.org, daniel.thompson@linaro.org, 
 jingoohan1@gmail.com, deller@gmx.de, robin@protonic.nl, javierm@redhat.com, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
In-Reply-To: <20240305162425.23845-1-tzimmermann@suse.de>
References: <20240305162425.23845-1-tzimmermann@suse.de>
Subject: Re: [PATCH v4 00/10] backlight: Replace struct fb_info in
 interfaces
Message-Id: <171103756721.89062.17090257592751026195.b4-ty@kernel.org>
Date: Thu, 21 Mar 2024 16:12:47 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 05 Mar 2024 17:22:33 +0100, Thomas Zimmermann wrote:
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
        commit: f1ecddf747f0d734682152b37c927aa958a51497
[02/10] auxdisplay/ht16k33: Remove struct backlight_ops.check_fb
        commit: dddfda7d5f12a7b48aeca6c3840167529c8cd34a
[03/10] hid/hid-picolcd: Fix initialization order
        commit: a951a15002da620871d8f3d8218c043cdc4c2471
[04/10] hid/hid-picolcd: Remove struct backlight_ops.check_fb
        commit: b3c52552f8d8a816bda2bda984411c73f4dd0b87
[05/10] backlight/aat2870-backlight: Remove struct backlight.check_fb
        commit: 0e03c96046405281fb072c05a7810d2661a2f334
[06/10] backlight/pwm-backlight: Remove struct backlight_ops.check_fb
        commit: 78534967e7cb3c2fbfcb2d37820b51a80c570f90
[07/10] fbdev/sh_mobile_lcdc_fb: Remove struct backlight_ops.check_fb
        commit: b853c08cd6598b3b3ff91cb2bba336bfef9c0ac4
[08/10] fbdev/ssd1307fb: Init backlight before registering framebuffer
        commit: d5ae81e965953da27cf46db6281d6a6a28eaaccb
[09/10] fbdev/ssd1307fb: Remove struct backlight_ops.check_fb
        commit: ec5925ef4a2dfd7ee060f4fd2a2e8036f8a94e8e
[10/10] backlight: Add controls_device callback to struct backlight_ops
        commit: 2e427743de015c1ac047036ef495c3f004105439

--
Lee Jones [李琼斯]


