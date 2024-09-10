Return-Path: <linux-pwm+bounces-3183-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A392972AF7
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 09:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAB2286FE8
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0EF17E00F;
	Tue, 10 Sep 2024 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5VqmMrW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236B17DFEF;
	Tue, 10 Sep 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954073; cv=none; b=iLZXHP6NJgCJxhRqVC6+CMq76V3nE2x7nIsiK8cpD8yYrnScEjgGXPhpB5upb7sWKU5oPcHH9eXfKQwaPbf9YnXVKyRrhqqZXunpxeFar1h69/D2pkb/13ap5Kywv8v36Oky9E0MvK0eU4umcU9wklFm4Hbn88NO6wAngeN1c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954073; c=relaxed/simple;
	bh=snAB2tdXCnqKC6Qfh4W9stiXFqOoO8KWhEKAuOrN4UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuxhDpfwQYEvW9FsjhRzqXt8QecirHpMf+J14FohD0n8iJ4bx5mq2yetvIRvooNxWDJvQPfNZyGXjufpu/9ccgi+7CgyUXzFCUgBP7vEc5TTmOn1n7+sxmU6wO3Jkm8RtZjahLFwD/LQwyFrTRo3Xsfg3w7JspR6kZqG9g9HIco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5VqmMrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D690C4CEC3;
	Tue, 10 Sep 2024 07:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725954072;
	bh=snAB2tdXCnqKC6Qfh4W9stiXFqOoO8KWhEKAuOrN4UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5VqmMrWsbd6uECOztim29wGz414g5qg2DEABQl1yTEwZXgSGWOnM8CSQ+yWR1Xfg
	 T3IZGyR/ySFDS5s8RS25TBTlAP1znCAaCW14XrPIgYIIrCoBtMJmlCvjdOhhY8ZgAU
	 qAlblk7drRkqScptp5TnwwTChdtfPbar4JvV/iE/pKLb4IMuV86798cIDdN9PRYpiG
	 H5b+mBmhxWo69OzcnCgDVB0VVN16R05g8oF2Soev2MohY64RLvVHRZLCZtWg0L43Cx
	 WrTpWvjpHJHEAs95EnfBt8sHBNLHU6znbQy2kPRHTlrW5JnJEt2zWe34LFtP1O6YgX
	 /O6OE44c2ao7g==
Date: Tue, 10 Sep 2024 09:41:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: sophgo: add PWM controller for
 SG2042
Message-ID: <33wi6plp5ebovfzl64cndw532ob75bwlpn74ldnqd2ggktrp6z@tooe3usdh3cl>
References: <cover.1725931796.git.unicorn_wang@outlook.com>
 <c2b237b5b2430b0715c9c3dee043d30fe5216e2e.1725931796.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2b237b5b2430b0715c9c3dee043d30fe5216e2e.1725931796.git.unicorn_wang@outlook.com>

On Tue, Sep 10, 2024 at 10:08:10AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Sophgo SG2042 contains a PWM controller, which has 4 channels and
> can generate PWM waveforms output.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


