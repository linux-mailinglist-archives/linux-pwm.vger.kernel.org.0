Return-Path: <linux-pwm+bounces-3117-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E3C96E7D4
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 04:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF071F21F37
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 02:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED61335A5;
	Fri,  6 Sep 2024 02:44:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D63FEC;
	Fri,  6 Sep 2024 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725590692; cv=none; b=Y/oFLYNUX9B06L8Gcb3G9S8mycv9XsNljh245lxwGFOP2xFPmzByZxjwn8A57QJpVFQNZfQ/trlErYrQjrvLV05EM592WohhQHHJold94pIa13+Kpwx5kzkRVJpSoYVeFbQskqtIaXn2PjygOlmkPiR5x9vQBlxvPcB8e1ecuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725590692; c=relaxed/simple;
	bh=VV52VXoWLrFhXBps8jUwvkb83JFMjXm3wp1RK9se4i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEoELf6HxeAkNNcZEzUfTUyNRWyLXd/DjGR8JHh3t7Rwfwk430UfTHWQCuCeY4hLAgRsQsBIGnLEdHW48DJXCIdZRMLD9m9Rg7S5G8vuXHp5LS+iG3zxGCWkunuW4siJoew/STcHhi7ibJhPUolK5rLu074OptlxmsKpbNiGH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 6 Sep 2024 02:44:35 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, unicorn_wang@outlook.com,
	inochiama@outlook.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: Re: [PATCH 1/2] dt-bindings: pwm: sophgo: add bindings for sg2042
Message-ID: <20240906024435-GYA153340@gentoo>
References: <cover.1725536870.git.unicorn_wang@outlook.com>
 <6e5fb37472b916cb9d9abfbe3bea702d8d0d9737.1725536870.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5fb37472b916cb9d9abfbe3bea702d8d0d9737.1725536870.git.unicorn_wang@outlook.com>

On 20:10 Thu 05 Sep     , Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add binding document for sophgo,sg2042-pwm.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> new file mode 100644
> index 000000000000..10212694dd41
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 PWM controller
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +description: |
you can drop | here
> +  This controller contains 4 channels which can generate PWM waveforms.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +
> +  "#pwm-cells":
..
> +    # See pwm.yaml in this directory for a description of the cells format.
I think you can drop this comment, since no useful information added
also it's already refered to standard pwm.yaml
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
also "#pwm-cells"?
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm@7f006000 {
> +        compatible = "sophgo,sg2042-pwm";
> +        reg = <0x7f006000 0x1000>;
> +        #pwm-cells = <2>;
> +        clocks = <&clock 67>;
> +        clock-names = "apb";
> +    };
> -- 
> 2.34.1
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

