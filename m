Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67471C38EB
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2019 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbfJAPYe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Oct 2019 11:24:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52180 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfJAPYd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Oct 2019 11:24:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so3876143wme.1;
        Tue, 01 Oct 2019 08:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qIz20MyIeJ4YRS3q69VVUyLU1/qqd5R6Zf74yV/b9ww=;
        b=tMJR1DKYuJ/HYqsTxR6if2fyU/wWMRmpHG62KZ1lIyk8JSPisThK+ZTZA0bRN3kEnu
         iJxykDLKTqLRSjAlHGp4hAzoB6bnBZmdBteJ+qDSgQhAORi7GTtM709ySi2rfGB4vEN3
         219q4uDcK6YA5/EWxdJU9yAkaUSaKoNT3LKOLeaA6ewjk3RUsN+1TMaiAzLk/V1MUoXW
         4PTxHFlRMJa4jw/2xO4qPBt6sAvA7L+Bze5tfvRB9I7d4YfzL8lgjmsBDZnTvqVLXWz/
         XGFDEAGo9bugFgonAmPeD1kBcRCxZnxB4W9aG5bA/UkMWXVtsdEcBCDmbDsbneYAfHYu
         mP9w==
X-Gm-Message-State: APjAAAUQXk3ONav8skZU1A/Cql1LXyee9IBgA4syfHBaHommjAKmA5ya
        mQGyO+Vw1bmJHnRTu+tZJ84=
X-Google-Smtp-Source: APXvYqzgA01GZd24cae9Ug02bMZVgbmEoHDdIAy+uHttgtTk16j30giNWmxHikB8fPnYof+FbNzouQ==
X-Received: by 2002:a1c:60c1:: with SMTP id u184mr4104201wmb.32.1569943469278;
        Tue, 01 Oct 2019 08:24:29 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id i1sm4699293wmb.19.2019.10.01.08.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 08:24:28 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:24:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: sram: Convert SRAM bindings to
 json-schema
Message-ID: <20191001152422.GA31358@pi3>
References: <20190918173141.4314-1-krzk@kernel.org>
 <20190918173141.4314-2-krzk@kernel.org>
 <20191001140003.GA31344@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001140003.GA31344@bogus>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 01, 2019 at 09:00:03AM -0500, Rob Herring wrote:
> On Wed, Sep 18, 2019 at 07:31:35PM +0200, Krzysztof Kozlowski wrote:
> > Convert generic mmio-sram bindings to DT schema format using
> > json-schema.
> 
> I've been slow getting to this because I started on the same thing...
> 
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Indent example with four spaces (more readable).
> > ---
> >  .../devicetree/bindings/sram/sram.txt         |  80 ----------
> >  .../devicetree/bindings/sram/sram.yaml        | 138 ++++++++++++++++++
> >  2 files changed, 138 insertions(+), 80 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/sram/sram.txt
> >  create mode 100644 Documentation/devicetree/bindings/sram/sram.yaml
> 
> > diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> > new file mode 100644
> > index 000000000000..8d9d6ce494b2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sram/sram.yaml
> > @@ -0,0 +1,138 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sram/sram.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Generic on-chip SRAM
> > +
> > +maintainers:
> > +  - FIXME <who@should.it.be>
> 
> You can put me.

Sure.

> 
> > +
> > +description: |+
> > +  Simple IO memory regions to be managed by the genalloc API.
> > +
> > +  Each child of the sram node specifies a region of reserved memory. Each
> > +  child node should use a 'reg' property to specify a specific range of
> > +  reserved memory.
> > +
> > +  Following the generic-names recommended practice, node names should
> > +  reflect the purpose of the node. Unit address (@<address>) should be
> > +  appended to the name.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^sram(@.*)?"
> > +
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - mmio-sram
> > +          - atmel,sama5d2-securam
> 
> I was trying to go down the path of putting all the compatibles for 
> various SRAM bindings here, but I ran into some issues. I need to 
> revisit as I've forgotten the exact issue.
> 
> This would need to be a 'contains' if this is going to work for others.

OK.

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    description: Should use the same values as the root node.
> > +
> > +  "#size-cells":
> > +    description: Should use the same values as the root node.
> 
> I defined both of these to be 1 as 4GB of SRAM should be enough for a 
> while. We can debate 1 or 2 cells vs. 1, but there's no reason it has to 
> be the same as the root (unless we're failing to do address 
> translation).

That was copied from txt version. I can adjust them to 1 although this
is will more than simple conversion.

> 
> > +
> > +  ranges:
> > +    description:
> > +      Should translate from local addresses within the sram to bus addresses.
> > +
> > +  no-memory-wc:
> > +    description:
> > +      The flag indicating, that SRAM memory region has not to be remapped
> > +      as write combining. WC is used by default.
> > +    type: boolean
> > +
> > +  # TODO: additionalProperties: false
> > +
> > +patternProperties:
> > +  "^([a-z]*-)?sram@[a-f0-9]$":
> > +    type: object
> > +    description:
> > +      Each child of the sram node specifies a region of reserved memory.
> > +    properties:
> > +      reg:
> > +        description:
> > +          IO mem address range, relative to the SRAM range.
> 
> maxItems: 1

OK

> 
> > +
> > +      compatible:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        description:
> > +          Should contain a vendor specific string in the form
> > +          <vendor>,[<device>-]<usage>
> > +
> > +      pool:
> > +        description:
> > +          Indicates that the particular reserved SRAM area is addressable
> > +          and in use by another device or devices.
> > +        type: boolean
> > +
> > +      export:
> > +        description:
> > +          Indicates that the reserved SRAM area may be accessed outside
> > +          of the kernel, e.g. by bootloader or userspace.
> > +        type: boolean
> > +
> > +      protect-exec:
> > +        description: |
> > +          Same as 'pool' above but with the additional constraint that code
> > +          will be run from the region and that the memory is maintained as
> > +          read-only, executable during code execution. NOTE: This region must
> > +          be page aligned on start and end in order to properly allow
> > +          manipulation of the page attributes.
> > +        type: boolean
> > +
> > +      label:
> > +        $ref: /schemas/types.yaml#/definitions/string
> 
> Already has a type definition.

OK

Best regards,
Krzysztof

