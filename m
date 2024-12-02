Return-Path: <linux-pwm+bounces-4179-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD19DFB63
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 08:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D696D280B92
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 07:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D21F943E;
	Mon,  2 Dec 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYnThTmd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5F481A3;
	Mon,  2 Dec 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733125226; cv=none; b=auThn5kRpSxN5MfQvn7dP2vgornKHSDiMW/L0zYmo5fEjlmu32RrpHCAzW/s6FSpBcSqr2CrUG05wMJaIW5SKXonzx9RNQ4pGUAlFC7HZ32Ulq5njON1DKPDQ1Xyz6Sato5JFprxekzTVLOhXNmZCHNzZymH3zFMfkRaFblRIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733125226; c=relaxed/simple;
	bh=Bnzy1S010Y17XKQEFMFoNNRKjmcdpbNqYLdlEjFvnP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWA3WQAdZ8Qyg7R7/+okPwpoIoyFwjPI6rqOjQwNo1EvKAm7a0hsIXtYSkBKdoeREE9MYHUxAwE9lNU8mNST0ZZbbKE2vDR6joTMf7A461IP26fy7mjujBwJhaouiWAm03pjBWhcFMCBu84EFCxBXYmOMtKwcjBunIbostmUiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYnThTmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADCBC4CED2;
	Mon,  2 Dec 2024 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733125226;
	bh=Bnzy1S010Y17XKQEFMFoNNRKjmcdpbNqYLdlEjFvnP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYnThTmd0lJQw+H6kN9Te9FWEIKcAntslp8XHfGvPPzUFi4Oxpu8PrUk2HOo5cLB8
	 vtXkarLTpRNcYVA8htzrLrP1YarsTfQYFzW9AZeuhoyTq+fFJ8a6m904+VPQELXdRe
	 h2MX2JXTMeTFwPiMJOipH9FSeBAldxnR/I5zsxApjDBRwpewNHqVlsE/GZOLBqUCMY
	 GSN0wRSJ7wtNe9XS5AcOjc6ic0RIvZckbQiescjVb+4YDqk25PY5NPqemlhcCczsiv
	 YJ1jRFjtOhB4006QMB49tSBoSL/FCotE80KL/cPr7Oa0LYAbee2Rg2GDQwRVvvIOMZ
	 69reVDXNReJBw==
Date: Mon, 2 Dec 2024 08:40:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add atcpit100-pwm
Message-ID: <qmbaftzr4ww35txfjvt6iao5g5jjikx5swgh6cdqbiu36dwo2y@74vnlk2a3ihn>
References: <20241202060147.1271264-1-ben717@andestech.com>
 <20241202060147.1271264-2-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202060147.1271264-2-ben717@andestech.com>

On Mon, Dec 02, 2024 at 02:01:46PM +0800, Ben Zong-You Xie wrote:
> Document devicetree bindings for Andes atcpit100-pwm.
> 
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> ---
>  .../bindings/pwm/andestech,atcpit100-pwm.yaml | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
> new file mode 100644
> index 000000000000..4b707f32ad72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/andestech,atcpit100-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes atcpit100 PWM
> +
> +maintainers:
> +  - Ben Zong-You Xie <ben717@andestech.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: andestech,atcpit100-pwm


Previously, before we removed it in 2022, this was just
andestech,atcpit100, so questions:

1. Why are you re-introducing it? Please address all the comments or
aspects leading to removal.
2. Why are you using different compatible? Is this one device?

Best regards,
Krzysztof


