Return-Path: <linux-pwm+bounces-3882-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C7D9B01F4
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 14:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2591F226BF
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AAB2022DA;
	Fri, 25 Oct 2024 12:12:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F42718B48F;
	Fri, 25 Oct 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858373; cv=none; b=fH5RAZNDs4hC2TM5c7EBxHvOJmCz89yytglJVXbJ5EtuCsZ6B1umgR9/euIIbX7wTnxv3UQuFu2Qp1sqpJk6gemgvMDC1swpyQbE8Zn4nE+jDvk+TK7PrDFk59hljirCpdUhPEMUu/ATt01Luxyp3tCsnpDeeSNrzN5K6SavfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858373; c=relaxed/simple;
	bh=b4uuKeXgOPSO+g0tZ7fMx6sSlHI+EtSou0hJQxJ8Wh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt0IbLs8MFr1MKyl72mFiti8Xgq3GbBBUyb1LqBUixEY1WOoC8MLDzURbHmJXLRwX+AAknV7v89DJBjMeKQyHEGAHuGzkID/qq7OfryjobuPTOStMdDDhsRE2iBuoCMleG62rqW6bkVtrvZbCdwKHJ6NcFCDrRlP6TBkFWF8PCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9DAC4CEC3;
	Fri, 25 Oct 2024 12:12:52 +0000 (UTC)
Date: Fri, 25 Oct 2024 14:12:49 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, ukleinek@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, inochiama@outlook.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
Subject: Re: [PATCH v5 1/3] dt-bindings: pwm: sophgo: add PWM controller for
 SG2042
Message-ID: <ju2a2iddftauzvei5arnsswnrpknduyqxmrpvljvnx5zbk6drm@dwpdheyq7vkm>
References: <cover.1729843087.git.unicorn_wang@outlook.com>
 <9f9a31a2a19c2743aea36c479b0dc32da0fec629.1729843087.git.unicorn_wang@outlook.com>
 <MA0P287MB2822127FBFCCE72631154EE6FE4F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822127FBFCCE72631154EE6FE4F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>

On Fri, Oct 25, 2024 at 04:11:20PM +0800, Chen Wang wrote:
> Hi, Krzysztof,
> 
> Since the changes are minor compared to v4, I have kept your signature. If
> you find any problem, please let me know.
>

It's fine, thanks.

Best regards,
Krzysztof


