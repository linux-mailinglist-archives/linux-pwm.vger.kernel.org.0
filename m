Return-Path: <linux-pwm+bounces-5656-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A52A96D9F
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB21B60067
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B62857DF;
	Tue, 22 Apr 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOY6AT4F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35B277809;
	Tue, 22 Apr 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330206; cv=none; b=Z3SyPDbeVJ59aMrFSyQ8LOeM8l1LaAxlHrzyCt3LqGnTiwSH1Y5XsJ3QwqIDYN5xibGaVXgIk+USVaPymzwwgAJ1agD4+qmu21GRUQAOZAgJb0EHlxGHIxnM27uUNBUiw1g35GlAX6rsdIaLcGNbZD0Pjnw8qIjTkhP7Au83akw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330206; c=relaxed/simple;
	bh=xJlyGlnTsnJ9Pp7pikKgN/l45mZmZ7KWpkphwcDOGAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyaN80MkS+Ic4zOK5IxzTrgpQe2sfi48vp/Moleo7+ZxnW6KBZ88Lwm3RBwxUjOFzv9UgMpuNmYvyTs7gWLuAMeJKiBcpr500SS/7caE/ZM4o03zmY/LYMHDVqnE6vT68yG9hKAbZFkCIECELN3fGBPmhUu/Atk7qIQSCgWcVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOY6AT4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD3DC4CEE9;
	Tue, 22 Apr 2025 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745330205;
	bh=xJlyGlnTsnJ9Pp7pikKgN/l45mZmZ7KWpkphwcDOGAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOY6AT4FzIEvYYR7UyvgUUKmT4OuKcvmUXY4a5Jflwq0C6Fz0QjXK9fwBMa9SX54/
	 elyvEwDp4LzXbwZ2/7NfaaTOqeSsTcyOgaEwMUksHz4Mwyq2YRUuNFkuGL1muHICuV
	 gatW/CcEUndSrrSuZUc6fak3b5uSPGcQoB7mkSmbiVkrBrIkJM4EMlssZZlcAPJQtX
	 K2TaZr/h+HItpsX1YYAj8jfaBqPJsnclgXiW3C5ZJZ1Wbi6EqRfRpAYbujNzGWORfZ
	 DePaJd8KWWDRVZhJJi2wHU5EjG/c9EOQPmL03mS8iSCI26A+sMYuKwqkT1zqtwgmo9
	 48qGzMM6r57dg==
Date: Tue, 22 Apr 2025 08:56:43 -0500
From: Rob Herring <robh@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: sophgo: add pwm controller for
 SG2044
Message-ID: <20250422135643.GA1132004-robh@kernel.org>
References: <20250418022948.22853-1-looong.bin@gmail.com>
 <20250418022948.22853-2-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418022948.22853-2-looong.bin@gmail.com>

On Fri, Apr 18, 2025 at 10:29:44AM +0800, Longbin Li wrote:
> Add compatible string for PWM controller on SG2044.

That is clear from reading the diff. What would be useful is details on 
how the h/w is different from SG2042 (and hence not compatible with it).

> 
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

