Return-Path: <linux-pwm+bounces-2782-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A192FAAD
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 14:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8E31F21B05
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964516F826;
	Fri, 12 Jul 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLlcjMkp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA07EAC7;
	Fri, 12 Jul 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788741; cv=none; b=Hu3aZhrLFM3oBeeBgsWbAfOR8Hdo18a33fxLDlbyo+esAbrkB3B54JnMaP3M9w864F/BcTQOJKzH/WP69eaD6w1JtK42KswgEi8BJAGApgVq9HpVUNRqDPg3hkUncyb8OYQw7eelzvSuGMpxryd8fy9nkRKT3MEB1dPjChOfglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788741; c=relaxed/simple;
	bh=K/5xWWbqZi9trgeRZCDyR2pMp0A5m1JDTg3308v8IQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKuG7P32y/FeU4vcWuXUbjlg7kQYXQOd4aQQNxp2q09L5Q71OVkphslvWKNm+EnHNH1vJVn3zWDrpDwbYI196s+JlQYOU3GdVX0FhefIhxv+FGg8lplVsNn0tdW1/ohePvRdQeDEKQXERDXCpJLY9Nyg/46Z5HuCRcbL0QYITyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLlcjMkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5C5C32782;
	Fri, 12 Jul 2024 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720788740;
	bh=K/5xWWbqZi9trgeRZCDyR2pMp0A5m1JDTg3308v8IQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLlcjMkp6NfuCvjZuu4UGlzFjaStGS356nHf+0YdpSSw8EZWAXD8u2e1RMK2Nsn8X
	 ypZeUVVY0IS3d9VX+m8Z2acna0W1jwmmAmiqes4ZJrU7yoRPE3cX9gqHNBtxNnMOwq
	 5pX1bSQSePaT6csyQ5vOrcZgVoQYf1JmyhvLYPC6fp/g/vcnlkBAPxhuSRjDKZQvkr
	 N17c/9XtwLY2hjLIPlpYy/B1isXEHCYb6nJb1y6BuBzgmFqjbjmHFmUDyYAwmxk4a0
	 2f/fFp7lKVyT8sdVEO3zKtzotAZwqoEKiRtbpNOVlDPe69PLsrTORzhFlFVquiEGL/
	 Z+gSn3PLa8N9w==
Date: Fri, 12 Jul 2024 06:52:19 -0600
From: Rob Herring <robh@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: ukleinek@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	neil.armstrong@linaro.org, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	hkallweit1@gmail.com, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 PWM
Message-ID: <20240712125219.GA472311-robh@kernel.org>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
 <20240710234116.2370655-3-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710234116.2370655-3-gnstark@salutedevices.com>

On Thu, Jul 11, 2024 at 02:41:15AM +0300, George Stark wrote:
> The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF.
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Missing ack from Conor. When you submit new versions, it is your 
responsibility to add tags.

> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

