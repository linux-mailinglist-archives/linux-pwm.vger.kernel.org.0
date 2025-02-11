Return-Path: <linux-pwm+bounces-4862-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760D9A316F4
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 21:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF5316843C
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396812641CB;
	Tue, 11 Feb 2025 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqL4tP4i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F024E4A8;
	Tue, 11 Feb 2025 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307372; cv=none; b=pIbkldbgK/k0rd3VhVmsxX3sArOShpH3WFweDUGqy3Ob4jwfS+iSeV6U9W1Ap++nxNYHX8c6L6csE55YZtLyXh46AujvZ5+kSAMq39m5xajNnR+VqTIlGJs96KAvYzcx1dKLZA15giHHu5ddNNoDz1Uj7jNCddR0lNTP+tVlkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307372; c=relaxed/simple;
	bh=1kS5pRqJHQNPF4gP4Lxw9NbXHOwh+4VmYGQP1qPNoLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJf3AgSkP9yUndhHzhoLu29cVFpDHItPoNY3ka25STd8BxOQpbZl3jOx95m4I1NrD/lydj+R0d0Kdf1EqwYNTxudYuOR24YSmf7a9lzcU6quaxo153D3JIgarozN8ftn8o+cz5KkqJqPHuujbHlwsAWeqjfxirsphapUo98ZkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqL4tP4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EABC4CEE7;
	Tue, 11 Feb 2025 20:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739307370;
	bh=1kS5pRqJHQNPF4gP4Lxw9NbXHOwh+4VmYGQP1qPNoLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqL4tP4i++KBlmQncBwrcb+Pi3NtoUsIyvPzIr2nC45U5LJaw5rDADzGUV4jqO31e
	 UZkSN3rhnATLbx5r+/H5kISE90GQHthoJ2GB+pvf4ePK3lsfwto4+d/e+aIavTWJRr
	 kDe2C09R0TyoIo0EJmXDrVC9zSaNn2mGewxuc5T5BCW8U6l2s20Pq6hw70w9fmgM4V
	 bsUA9Ke8W5ffkAveEIuFWBLHJwRW5nn0tDe2YC+mGfU6uZkVs+vJSV5O8gCbOMX7I8
	 rLpsAlSi1tOQwUl0eeNBeu9Vqk5vb7l//i1wC9T0lTTQ1lBuccMaKBdcZbW18eCs+L
	 Sy5GYbY4xw4nA==
Date: Tue, 11 Feb 2025 14:56:09 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add support for PWM nexus node
Message-ID: <20250211205609.GA1142491-robh@kernel.org>
References: <20250205095547.536083-1-herve.codina@bootlin.com>
 <20250205095547.536083-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205095547.536083-2-herve.codina@bootlin.com>

On Wed, Feb 05, 2025 at 10:55:42AM +0100, Herve Codina wrote:
> Platforms can have a standardized connector/expansion slot that exposes
> PWMs signals to expansion boards.
> 
> A nexus node [1] allows to remap a phandle list in a consumer node
> through a connector node in a generic way. With this remapping, the
> consumer node needs to know only about the nexus node. Resources behind
> the nexus node are decoupled by the nexus node itself.
> 
> This is particularly useful when this consumer is described in a
> device-tree overlay. Indeed, to have the exact same overlay reused with
> several base systems the overlay needs to known only about the connector
> is going to be applied to without any knowledge of the SoC (or the
> component providing the resource) available in the system.
> 
> As an example, suppose 3 PWMs connected to a connector. The connector
> PWM 0 and 2 comes from the PWM 1 and 3 of the pwm-controller1. The
> connector PWM 1 comes from the PWM 4 of the pwm-controller2. An
> expansion device is connected to the connector and uses the connector
> PMW 1.
> 
> Nexus node support in PWM allows the following description:
>         soc {
>                 soc_pwm1: pwm-controller1 {
>                         #pwm-cells = <3>;
>                 };
> 
>                 soc_pwm2: pwm-controller2 {
>                         #pwm-cells = <3>;
>                 };
>         };
> 
>         connector: connector {
>                 #pwm-cells = <3>;
>                 pwm-map = <0 0 0 &soc_pwm1 1 0 0>,
>                           <1 0 0 &soc_pwm2 4 0 0>,
>                           <2 0 0 &soc_pwm1 3 0 0>;
>                 pwm-map-mask = <0xffffffff 0x0 0x0>;
>                 pwm-map-pass-thru = <0x0 0xffffffff 0xffffffff>;
>         };
> 
>         expansion_device {
>                 pwms = <&connector 1 57000 0>;
>         };
> 
> >From the expansion device point of view, the PWM requested is the PWM 1
> available at the connector regardless of the exact PWM wired to this
> connector PWM 1. Thanks to nexus node remapping described at connector
> node, this PWM is the PWM 4 of the pwm-controller2.
> 
> [1] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/pwm/pwm-nexus-node.yaml          | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-nexus-node.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-nexus-node.yaml b/Documentation/devicetree/bindings/pwm/pwm-nexus-node.yaml
> new file mode 100644
> index 000000000000..55412fe50d01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-nexus-node.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-nexus-node.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM Nexus node properties
> +
> +description:

You need '>' on the end to preserve paragraphs. With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

