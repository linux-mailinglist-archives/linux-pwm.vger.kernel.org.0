Return-Path: <linux-pwm+bounces-4927-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74983A374FF
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 16:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538A218909F4
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC931991CF;
	Sun, 16 Feb 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V514WN5o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D94C8E;
	Sun, 16 Feb 2025 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719310; cv=none; b=EBAKmJqMQvC/a76ISu5iiFzDxFhNSHcQ04DkLETz12Ki/yyzGjZUS99ncKiaRS5PebqaXD78WugeKX6mi2K/BasCS8vQiA9QR9FYPWTPuRKPpqBkO3QiLOfkO1RcQNdqv9fdmihaiO8Dy9NawFJgWT+CL5jPfMTJ8D6E5/f6iNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719310; c=relaxed/simple;
	bh=LoTdb55Vt3V5ivelM/VxXe3A+oY+aRzrdNzQEChBMFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glB5RFAXWsgvBwfjirYDupXBA3cYzi1b5I2gSYoy8VH78kJVfoh6lZhnXLdDKb0BvroVwgnR7j63TJx8L6D1o3m8dgfM2993RFxUfPdDSHchw7l4FFomIfHp0/L1RFJ1SorOV+iEyZmthC/CM0Bf+UPakzXwrfdp8P0YpZlM70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V514WN5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5B6C4CEDD;
	Sun, 16 Feb 2025 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739719309;
	bh=LoTdb55Vt3V5ivelM/VxXe3A+oY+aRzrdNzQEChBMFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V514WN5obi4jndGCZIvkXAiTu0u48JTy5M0ND5XzapZqhMqVn25gSmMxDCXIVTK/C
	 s+xQtQKh8MMxwQF1N9g70WKMPmiKovkhQCfPcM7pGaQ5046R51bCMaZcrzh2VoWWwE
	 A4qHv85YdxeUy8V7q1q1F4U5DXk6Y9E257vB1Q3o+dJ+qaqzbLorhYLCDgJGhFVVlZ
	 nXtbosATrFjVWdV0zEN21fxfd4/O6IJr1hPTImYkcZee9J5bGPwRTLRFzglw7cdBKq
	 Q8nwI67JZeiwKNXYF0O3tapi85Witu1WuvH19k57eIxGsKsekqomyA1VcNXlH8ieoX
	 xBJs6oqu2NrRA==
Date: Sun, 16 Feb 2025 15:21:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v13 6/9] iio: adc: adi-axi-adc: set data format
Message-ID: <20250216152140.605298ca@jic23-huawei>
In-Reply-To: <20250214131955.31973-7-antoniu.miclaus@analog.com>
References: <20250214131955.31973-1-antoniu.miclaus@analog.com>
	<20250214131955.31973-7-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 15:19:52 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for selecting the data format within the AXI ADC ip.
> 
> Add separate complatible string for the custom AD485X IP and implement
> the necessary changes.
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
This also needed hand merging, please check the result.  I shuffled
a few things around to what felt like a more logical ordering to me.

Jonathan

