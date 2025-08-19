Return-Path: <linux-pwm+bounces-7106-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC0B2CE1B
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7344E48B6
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 20:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85497341ADA;
	Tue, 19 Aug 2025 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="2t0nH+rw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E233EB02;
	Tue, 19 Aug 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635617; cv=none; b=KmbvrB8oQCLQJ30Zx4mpDSj2aYILb/Sl17YIxb2OlOpn2ortmN0he8V3QWqFbkymAcTUw9M8vdUzBB15wGQvTpP9l2mCw+rqqEE9KXbz4yDFUriJvM6+khxfW8omcXhgTa0T6YRhyW5fCZw6IlPngCTWdYBel6FQMtYo6oOx1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635617; c=relaxed/simple;
	bh=u0jHy+96xQQc8Rsq14s4xOxOiOUOUoyteYoE2V6u/cs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keESg/ZanVvBfLjES84GrfeI+YIOghKKARACJ7eGrtK3czKpvIaYtPXujFJMTCXzOpwxpcbs4UTK1qLS0mQYf38aBjhur/pt+GuGv1rKIUp6fCX+HWuB55veivIBgWQb0EZb93Shxv6qsywn7SNCygIag0gKxs7/GV7p1iFXnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=2t0nH+rw; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1/eUspNCUXyY5YlWldBkBwRS3SFcnhUn4WjHQtP/9wc=; b=2t0nH+rw7E8V78kWenP4au6K+4
	exEwfVKJi8b0tPVduqB/o8rbtRCeUrCKje/ykiFOZopI3RhEtqZdqmYdm7DBGNefeRThMQJBt195Y
	ADh1TgtWB7gNOx0iXJr67Cd9r/Ru148qKSOr2Ur3tE2CNtKuPFpxtpeWEqTlzh5VC3bft21T59xs4
	3W/lkEzBbkczajoZIHzdhxFvbTaNAMXk1aNkAmSOAzyml43d0lDOd5EeHWpkyPExCBw03X66X2jmo
	qIcEJJZbRla6DLBwkNeNn7lmyaF6Spxrn3gymHy0JHTIWpmhFX7vDrM8+SQdSS+IwK0GWYxC6IZ1E
	5V3lht2A==;
Date: Tue, 19 Aug 2025 22:31:57 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, linux-kernel@vger.kernel.org,
 peter.ujfalusi@gmail.com, dmitry.torokhov@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
 conor+dt@kernel.org, lee@kernel.org, ukleinek@kernel.org,
 broonie@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 brgl@bgdev.pl, aaro.koskinen@iki.fi, khilman@baylibre.com,
 rogerq@kernel.org, tony@atomide.com, linux-gpio@vger.kernel.org,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250819223157.0b271c74@akair>
In-Reply-To: <20250819-humongous-muscular-curassow-5accd5@kuoka>
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
	<20250816021523.167049-2-jihed.chaibi.dev@gmail.com>
	<20250819-humongous-muscular-curassow-5accd5@kuoka>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Tue, 19 Aug 2025 10:13:39 +0200
schrieb Krzysztof Kozlowski <krzk@kernel.org>:

> On Sat, Aug 16, 2025 at 04:15:18AM +0200, Jihed Chaibi wrote:
> > Update the TI TWL family Device Tree binding to include additional
> > subnodes for TWL4030, TWL6030, and TWL6032 devices.
> > 
> > The simple power and PWM bindings (ti,twl4030-power, ti,twl-pwm, and
> > ti,twl-pwmled) are now defined directly within this binding.
> > 
> > Other child node definitions (audio, gpio, keypad, usb, etc.) are also
> > added to the schema. These additions fix 'unevaluated properties'
> > errors found during dtbs_check for boards like the omap3-beagle
> > and improve the binding's overall completeness.
> > 
> > Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> > 
> > ---
> > Changes in v3:
> >  - New patch to consolidate simple bindings (power, pwm) and add
> >    definitions for all child nodes to fix dtbs_check validation
> >    errors found in v2.
> > ---
> >  .../devicetree/bindings/mfd/ti,twl.yaml       | 191 ++++++++++++++++++
> >  .../devicetree/bindings/mfd/twl4030-power.txt |  48 -----
> >  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
> >  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
> >  4 files changed, 191 insertions(+), 82 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > index f162ab60c..b0f1cb7b5 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > @@ -76,6 +76,98 @@ allOf:
> >            properties:
> >              compatible:
> >                const: ti,twl4030-wdt
> > +
> > +        audio:
> > +          type: object
> > +          $ref: /schemas/sound/ti,twl4030-audio.yaml#
> > +          unevaluatedProperties: false
> > +
> > +        keypad:
> > +          type: object
> > +          $ref: /schemas/input/ti,twl4030-keypad.yaml#
> > +          unevaluatedProperties: false
> > +
> > +        pwm:
> > +          type: object
> > +          $ref: /schemas/pwm/pwm.yaml#
> > +          unevaluatedProperties: false
> > +          description: |
> > +            TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
> > +          properties:
> > +            compatible:
> > +              enum:
> > +                - ti,twl4030-pwm
> > +            '#pwm-cells':
> > +              const: 2
> > +          required:
> > +            - compatible
> > +            - '#pwm-cells'
> > +
> > +        pwmled:
> > +          type: object
> > +          $ref: /schemas/pwm/pwm.yaml#
> > +          unevaluatedProperties: false
> > +          description: |
> > +            TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
> > +          properties:
> > +            compatible:
> > +              enum:
> > +                - ti,twl4030-pwmled
> > +            '#pwm-cells':
> > +              const: 2
> > +          required:
> > +            - compatible
> > +            - '#pwm-cells'
> > +
> > +        'twl4030-usb':  
> 
> No need for quotes.
> 
> > +          type: object
> > +          $ref: /schemas/usb/ti,twlxxxx-usb.yaml#  
> 
> Are you sure your patchset is bsiectable? Apply this patch and test. You
> will see errors and you must fix these. Even after fixing you have
> strict dependencies so your cover letter must explain these (or merging
> constraints)...
> 
what are the rules here regarding bisectability? non-existing files
in $ref are probably bad. Are then unveiled errors in dts also a
problem? I would not expect too much fixing effort needed here. I have
not run dtbs_check yet.

I have expected this would all go via Lee's usual immutable branches. 

Regards,
Andreas

