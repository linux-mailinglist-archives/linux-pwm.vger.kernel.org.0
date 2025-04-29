Return-Path: <linux-pwm+bounces-5771-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5092AA0FFE
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 17:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49D41BA0FA7
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213B21CC4F;
	Tue, 29 Apr 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcWcj2ox"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105421B9E4;
	Tue, 29 Apr 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939041; cv=none; b=f49vkQnNKQtTQeobbUU86oPvk3MdRvP998ZUF/dJKo6AOE0RAVafgRE6TkcExpkEx/9kj4lj5kumsqCX7h3IOxJWRRDa9x+FLHNg+Nt8usCyCcoyR2HNPsj4XHckNdguxWlQfqOvPfkU+jnh1F2CX99DtHUtK9ApMBMXZsN1yhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939041; c=relaxed/simple;
	bh=NQ6rs0gAx8UaaZKGMW2O3mPB21o1FM4k1lKYkEfoXVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRYsIJQ8Sk7N6WQxnmkDKkDrrnMx35TZGJWYv5gikbCfu18bApGtKWS+5XvRlHBlIElYWyXPsml/NNLHl6yZj0/pc30l2zLUIyQpHUQN47MxrNyhUUmjpgcfmiMYnqZWpsH3FWTq8RtSYZMfrCevzy3qAwEdGCr6U8Pfd17gBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcWcj2ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1229AC4CEED;
	Tue, 29 Apr 2025 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745939041;
	bh=NQ6rs0gAx8UaaZKGMW2O3mPB21o1FM4k1lKYkEfoXVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcWcj2oxSKexKkkqMX8hZCj4YEE9wEd9S/JhZdWwGmLgv2jdVtQRf4v3fpIwy950z
	 fqVM7VrLb0NWWejI+JG9skw+1NXGPRE2vkhHqLsx/4uiTfbW0FsgISn6M0RxlTP5iT
	 69/kgPexmOGnXSERLBmIbhrMgKAsOYKeTYqiVLZrgTawahlZayC1mWOTOj6hTfjjTL
	 b1AYc8LseV5boePdNcwCbZYdzs/0e5fD8nTbbiSBkDWXiRperUDgBLX4JDxOsFsqSZ
	 OizxN/yets15PN1snTDYCHQykS4KFjx4Gz6rSXYAQLPGsGE5ct+FkAKno1HKcTOCAP
	 6AOUf4UpOQuCw==
Date: Tue, 29 Apr 2025 10:03:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 09/17] dt-bindings: mfd: adp5585: add properties for
 input events
Message-ID: <174593903898.4100627.2373563890493878506.robh@kernel.org>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-9-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-9-3a799c3ed812@analog.com>


On Tue, 15 Apr 2025 15:49:25 +0100, Nuno Sá wrote:
> Add properties related to input events. These devices can act as
> keyboards and can support events either via a keymap Matrix or through
> GPIs. Note that the device needs to be an interrupt controller for GPIs
> based events.
> 
> We specifically need a property specifying the pins used by the keymap
> matrix since these devices have no requirement for rows and columns to be
> contiguous without holes which is enforced by the standard input
> properties.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,adp5585.yaml       | 188 ++++++++++++++++++++-
>  1 file changed, 186 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


