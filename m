Return-Path: <linux-pwm+bounces-8542-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIbELHc62GmAaAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8542-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 01:47:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D59E3D0908
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 01:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF5143015478
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A883A2569;
	Thu,  9 Apr 2026 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAmDpI6p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403883A2542;
	Thu,  9 Apr 2026 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778234; cv=none; b=ai3DAcsDnhEaSoeXSZOpffn4eCQwapYDp+vAuQYrmlBXzVhqct8Na/QKvGpDabo1Ly7IdRBZC3Ux7H9FfZqrZPtvXbRmKlmqSnLk1LSrbJQL3jiVhgaxG+m4VGhLMfgXrQIt2A9B0RjodqRd8HtUoCZD8y2O05XXaKFJouNjR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778234; c=relaxed/simple;
	bh=gAUOUKeQWfXMQS+gwzMyPSCdGvq7t2FyRZ1piCNyVsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHBu+a6YvjrfYH9D1MLlUR41Lokg/QFwKdiNNANq2hWPSHvO4lyxkLCoHrPG4IYZFQ7gS/ecBOdbB54WtslU+ZEFd3LSNV/MLJ8NIzX+nK0EuH1j/Kj8AJ3wllQTTfQVlzcPTwJq98GK4QGm3MLhhhluxFaatfVY6YSgvVtPlvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAmDpI6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58292C2BC87;
	Thu,  9 Apr 2026 23:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775778233;
	bh=gAUOUKeQWfXMQS+gwzMyPSCdGvq7t2FyRZ1piCNyVsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAmDpI6p5H0OzeaMLCTzHNoflFqzKwKYdloMNxBi+6kGcMaa4S6XHSQ9wg5Wd2jcP
	 hy+C8CQSJihzNs6WDtWiTnma3TI+IKBcM0eVxqMxPrDOo3PevseGl26/51rvAA4YIG
	 VG3oYhF9d4HAYX/lDdTcrD3jxGWifNabJHPFhl1M/iMjcjiukfx35yyorXaozrTqqP
	 Ox7EUsiNQ8S0sKwtrnMmgH39FKcQqDMQq4v2N+q45JKihxhiEwJVX5k7FpKxDFyUnD
	 IsMTRDGdVcTP0ERDCfC0o8yblXIhHFBYzaJRswWrryilqniMO23nc0rMuc1s83Bjog
	 09JY03oEqpviA==
Date: Fri, 10 Apr 2026 07:43:51 +0800
From: Yixun Lan <dlan@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K3
 PWM support
Message-ID: <20260409234351-GKA1160389@kernel.org>
References: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
 <20260409-03-k3-pwm-drv-v1-1-1307a06fba38@kernel.org>
 <20260409-laboring-announcer-4a0f9ca152a1@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-laboring-announcer-4a0f9ca152a1@spud>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8542-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D59E3D0908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Conor, 

On 16:41 Thu 09 Apr     , Conor Dooley wrote:
> On Thu, Apr 09, 2026 at 12:45:11AM +0000, Yixun Lan wrote:
> > The PWM controller in SpacemiT K3 SoC reuse the same IP as previous K1
> > generation, while the difference is that one additional bus clock is
> > added.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   | 53 ++++++++++++++++++++--
> >  1 file changed, 50 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> > index 8df327e52810..3427c8ef3945 100644
> > --- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> > @@ -15,7 +15,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: spacemit,k1-pwm
> > +            enum:
> > +              - spacemit,k1-pwm
> > +              - spacemit,k3-pwm
> >      then:
> >        properties:
> >          "#pwm-cells":
> > @@ -26,6 +28,38 @@ allOf:
> >            const: 1
> >            description: |
> >              Used for specifying the period length in nanoseconds.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - spacemit,k3-pwm
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          items:
> > +            - const: func
> > +            - const: bus
> 
> This condition here doesn't appear to do anything? It just repeats
> what's already done unconditonally below?
> 
You right, I should merge clock-names with below..

> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - spacemit,k3-pwm
> > +    then:
> > +      required:
> > +        - clock-names
> > +      properties:
> > +        clocks:
> > +          minItems: 2
> > +        clock-names:
> > +          minItems: 2
> > +    else:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +        clock-names:
> > +          maxItems: 1
> >  
> >  properties:
> >    compatible:
> > @@ -36,7 +70,9 @@ properties:
> >            - marvell,pxa168-pwm
> >            - marvell,pxa910-pwm
> >        - items:
> > -          - const: spacemit,k1-pwm
> > +          - enum:
> > +              - spacemit,k1-pwm
> > +              - spacemit,k3-pwm
> >            - const: marvell,pxa910-pwm
> >  
> >    reg:
> > @@ -47,7 +83,18 @@ properties:
> >      description: Number of cells in a pwm specifier.
> >  
> >    clocks:
> > -    maxItems: 1
> > +    minItems: 1
> > +    items:
> > +      - description: The function clock
> > +      - description: An optional bus clock
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    oneOf:
> > +      - items:
> > +          - const: func
> > +          - const: bus
> >  
> >    resets:
> >      maxItems: 1
> > 
> > -- 
> > 2.53.0
> > 



-- 
Yixun Lan (dlan)

