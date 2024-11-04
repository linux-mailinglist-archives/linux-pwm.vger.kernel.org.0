Return-Path: <linux-pwm+bounces-4022-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371EA9BAA51
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 02:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6631F212E4
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 01:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14315ADA6;
	Mon,  4 Nov 2024 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUDKZ6Ux"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC926AF6;
	Mon,  4 Nov 2024 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730683796; cv=none; b=qkk4hquaDc/KDOULZnrFazt+HQaAzH4Lw5TE6SDEvjNCUXNJgoH3/Snpcm4kPl3PPkPhE++l09YMintrsMOApMP9ewUXGD+dkRjAAfku0rHp45F+jOKpR7j87OtJHXW8EB0s1eo3JxjXOLeW5/96CidFLm6LOGeGGNWHAkeCU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730683796; c=relaxed/simple;
	bh=hfuB5itnGYPzAEt+47JNgDkjO30ZfSS9cGPfrm2zg+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9LGqmBz5O1nq/QEhx0/lXowTOQ6Az4VkADMLJ0/GOLKwagineFIdf4BMiCB1zA6RIjZeJxWXrHnHYDNjEYRFqzHoX9QAsIT0WHqkMjooKCDzqciOtKB/iuC8PvGvo5uU4UNimfs5tN2RKKmI7W/zE6OGU2HzKry9sXM/l3ziE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUDKZ6Ux; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc0e13d25so1280500eaf.1;
        Sun, 03 Nov 2024 17:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730683794; x=1731288594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ciyiua8QyRfHQceByjZysMoGm4YlaklrovUMSEjMlik=;
        b=EUDKZ6UxT8x46uFa4f2IJ2oBy01V8IW7G3A0Z2NO68/t2Wb4kIuHiYFx5oi6WJ7Ph4
         GSbuW6iId7oYWWTnO/OivqqAL4KP3mC1AH1236OwiW402rUSuaGeOibUumkIfoZJPCOa
         leGKRaaUD5i8B7CRivDoJjTw0xX6SHUgDUYdVTi1KWZtgfJ+7izcYSSDT4usFraWGOPe
         SqwxR4mv2TxoNsbsIwVw7hZFlroT/X1Bx7Pu9N0sUf9+cuNix0uEPfJL4hZOQduxrQMm
         ST0DCmGCZBqubYHq5jyZBT8bxkXlXWIjDdkRCdac8wcV4Mlofe6vcbIehc3ggBkI+puF
         NL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730683794; x=1731288594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ciyiua8QyRfHQceByjZysMoGm4YlaklrovUMSEjMlik=;
        b=crC1V3FUhcClGMckAGQcJtVlcAgRnwD28RV+UwO9TNOHQA+9NsNSM5XsaNaEvddCYI
         14pg+ai8YmuX2afL1goE1Tmxi6xrBsJAiA31393nc70vL8lreqRCEPDs9Tp/T9T9K50Y
         K9cTNmD54UgJLe8mYdILpbtbyKsfIrG88F97ob7GitW43ma4xVl/mFAMCssn6DJTrNf2
         0adFG6x5UlFQdMOXKLGJpRxhNirv7Rnf9jDatAqNC8icjYLoKrFcOe3yFI1FKoIFD7dZ
         XhDT5Fg2/l2aubesDx1xZt9rSVmb9I+tMIHPKCqflL1ZObDtDMLzWFs7HRsPJQzxKzkA
         I6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUVUF9RYxkOYKJzw0pKX0jfp/GyPHb7ZujyYcolJMNKQ/pcRK8Cswc8ZHqHYrPwelpsF3LzEmSgcW70M7Mq@vger.kernel.org, AJvYcCXHmrPS+UroE//O5hIVnth1R7WQSnUTucZSEOPEK8G+VJ8WewcywSoF6tlkJHuJkd7JvZU4xaMvVlS/@vger.kernel.org, AJvYcCXna69NiumoiBP7p5fkvZTXh6XylkVvYxQVXLtksBlXbsnEdfItL6/LXc4A7/Gp1/Zq8YyBf8BiGT1B@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0ShugbZBwJ/WZrQGy+b/CfyttjJVbsHeC6RqSxSqJ3LkKVrF
	DXzQuWsnzwDBgrvpwdr7r0tmfGOFKHzHOuD/LwLhdjjmdiqMARnw1iSZdgz4IdPnkiSnBv5HIGm
	y0erG4RYNRINdLj12hkv6bUjpvVRG4DDB
X-Google-Smtp-Source: AGHT+IF4AWGqWHu2SptkCgPPvAKr3uKgusbkJCTmrX28ZyUZ8NvXvwsXXchRukLG7grm0BrU1SC2Hz67qRnP06VRoPo=
X-Received: by 2002:a05:6820:1e88:b0:5eb:758c:fa64 with SMTP id
 006d021491bc7-5ec6db6d5f4mr7752175eaf.4.1730683793994; Sun, 03 Nov 2024
 17:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
In-Reply-To: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 4 Nov 2024 09:29:17 +0800
Message-ID: <CAAfSe-tk4iqeqxSbb8TmsauLC7X3KMtyM51cSdj2wXiC=-5-Yg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 17:36, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
>
> Convert the Spreadtrum/Unisoc UMS512 PWM controller bindings to DT schema.
> Adjust filename to match compatible. Drop assigned-* properties as these
> should not be needed.
>
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sprd.txt      | 40 -----------
>  .../bindings/pwm/sprd,ums512-pwm.yaml         | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.yaml
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> deleted file mode 100644
> index 87b206fd0618..000000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -Spreadtrum PWM controller
> -
> -Spreadtrum SoCs PWM controller provides 4 PWM channels.
> -
> -Required properties:
> -- compatible : Should be "sprd,ums512-pwm".
> -- reg: Physical base address and length of the controller's registers.
> -- clocks: The phandle and specifier referencing the controller's clocks.
> -- clock-names: Should contain following entries:
> -  "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
> -  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
> -- #pwm-cells: Should be 2. See pwm.yaml in this directory for a description of
> -  the cells format.
> -
> -Optional properties:
> -- assigned-clocks: Reference to the PWM clock entries.
> -- assigned-clock-parents: The phandle of the parent clock of PWM clock.
> -
> -Example:
> -       pwms: pwm@32260000 {
> -               compatible = "sprd,ums512-pwm";
> -               reg = <0 0x32260000 0 0x10000>;
> -               clock-names = "pwm0", "enable0",
> -                       "pwm1", "enable1",
> -                       "pwm2", "enable2",
> -                       "pwm3", "enable3";
> -               clocks = <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
> -                      <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
> -                      <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
> -                      <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
> -               assigned-clocks = <&aon_clk CLK_PWM0>,
> -                       <&aon_clk CLK_PWM1>,
> -                       <&aon_clk CLK_PWM2>,
> -                       <&aon_clk CLK_PWM3>;
> -               assigned-clock-parents = <&ext_26m>,
> -                       <&ext_26m>,
> -                       <&ext_26m>,
> -                       <&ext_26m>;
> -               #pwm-cells = <2>;
> -       };
> diff --git a/Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.yaml b/Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.yaml
> new file mode 100644
> index 000000000000..0344c2d99472
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/sprd,ums512-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum/Unisoc UMS512 PWM Controller
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>

I've moved myself to Reviewer in sprd entry of MAINTAINERS, so,

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> +
> +properties:
> +  compatible:
> +    const: sprd,ums512-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 8
> +
> +  clock-names:
> +    items:
> +      - const: pwm0
> +      - const: enable0
> +      - const: pwm1
> +      - const: enable1
> +      - const: pwm2
> +      - const: enable2
> +      - const: pwm3
> +      - const: enable3
> +
> +  '#pwm-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sprd,ums512-clk.h>
> +
> +    pwm@32260000 {
> +      compatible = "sprd,ums512-pwm";
> +      reg = <0x32260000 0x10000>;
> +      clocks = <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
> +               <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
> +               <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
> +               <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
> +      clock-names = "pwm0", "enable0",
> +                    "pwm1", "enable1",
> +                    "pwm2", "enable2",
> +                    "pwm3", "enable3";
> +      #pwm-cells = <2>;
> +    };
> +...
> --
> 2.43.0
>

