Return-Path: <linux-pwm+bounces-9424-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pDT9OdWxPmp5KQkAu9opvQ
	(envelope-from <linux-pwm+bounces-9424-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 19:07:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 863EB6CF582
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 19:07:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=McaFOsB3;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9424-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9424-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B303305489F
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB5400E0A;
	Fri, 26 Jun 2026 17:05:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D873839B8
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jun 2026 17:05:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493548; cv=none; b=gI/g7MgwjWOgJbnoxWo0w7Ts9rV3bhv+5gpiU0MY8Uy1uU6kMFXP7VKu78J2ZlcH/hA6cSaj0SU8q/03QOay8aIlof2ChoPoRWQDYCsWGzDoH6zSett5LySULCe/2PZMrXfFAVJnLjZ0u5p1gF3vRRckq4mLh2V1l96XkWx7+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493548; c=relaxed/simple;
	bh=XR8MOukhdb4119CLjtzkhC3PmY5hiwGnrBNevd09pJw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTL1r9FOvCs/7oVKoG/AZnbmlT3sILDcVg2buG0CLLurxopQk5jmT4WvRc51wVtopQixLfykA3uFr2U7/r3JlRd7+EVncq0MHTiNvX/qsAsHKdAWuD8DfAX1sjfaYkdH/OFcv57IsK4KZNzbdfQKjO5kEVrz4gy31fJXFWhANe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=McaFOsB3; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so11841795e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 26 Jun 2026 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782493544; x=1783098344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJMulB6FHoz3UwRU2js2Yx9wDg7dc99Kfk97uaLSZ70=;
        b=McaFOsB3pyEjPyeAdIflDv75XopeHatu+YSzKhNHhQtlOkGyx85Ij7KbmajKq2+mjR
         z/fU2cUtdulbHYDdK6qOP/lJKMcz6E1mu6PFfLU7lwLoqNdXaGx0oVyDv8cZ9l/SqBoO
         lreN028lCyzALA1YSHSBaXL/z/CjhHtYo4FFmi7ilIMXTh1TywTmcgvpQMq0D3UpDofX
         zhHA35JJoFLRl9NsUvbdc8LgmWQMVjEIZxHIOQeSRlQz02zZIpx3W/QFcVB36ugeO02v
         8QnJkBT/Hxmnx3UaG72Zm/hPPP+o/N3ObBvfih8S0m19LQoX64UkcURGJ/AdtmxOaPjd
         p5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782493544; x=1783098344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJMulB6FHoz3UwRU2js2Yx9wDg7dc99Kfk97uaLSZ70=;
        b=Aor56S3kFqyA0qeEvxcdUNq/7aAIj6x+rCMg1eMjH4NYphtrXF1oy03v6eWovpOLJf
         j7hGS5rW3cNkEBM0CVWdT6QzkD6+/z/py0pbnNkVVPTyVKWNWn4+QmX3lASweKQjn4UV
         69EHTFoLG5E6MWYQsXTuxq4LD/6W0bzgxIbfotTjS8ugG2hwzRxKXnsuzFn/Qvxwr/iY
         JmYLodclpp+J9cPIy4nSMvSYIQnPxF5+nd86rxgyg0tla+AIMlHiVSknHZhPSCvHxgNa
         YyJkYyfIYYuJueMEQEqEFiDb3XTWWVqsk+e4o0JuMIBT5C4Gu7bBF+z+kRwJtyDrIsQp
         gQQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qfdvx3ICb7H9Y0Ao+zF7Sz0DpT8xF8+aD4fB8ydx6BcKYpedq4GQAsQng10Vo0T/Juy9wcGhe5Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAs2K1LEixVaScCIOHL37aw6i8nuveI/7wYvmfD/BIlJWTSSuH
	1+tnsK6dPADAP4VufCorIpU+AJoMsCuAAk2TSAMs7qHbGElq757mOyWuXEknP6iWJaw=
X-Gm-Gg: AfdE7ck7ey2yhb6hqknUVnHAlJDFDYg3Yygf6TKpxnMR7n/6cwsfG1xUzq7IaRu9bjb
	Db6fOf/dmCjE1ofvqELQ1AA+w7dvHUuTcryT27bSn32mySQfWo2bg/eK5eALqnMnx0XHu6T2RYE
	DwLPDJG65z2nfZjlnbRbarFTYnzGE1KHW4EPMEF4sqpcQKQg3xNVXiBBCk+ODKRzTG9M8w7vGXQ
	q5nQgWkWCIhNe3yBt+nNEArVTdVutNPFSqYvjiAGVd8WzXBoJFLQ8pLtk9ZmA15ywZ1w03BdXHB
	SwhLl4/ltgrYZHwUJw1A0Gnux/Ve2S9Yn85QCkMWFlPEufNQy8ejIy+9tmlmlQllGm5tibgwkLO
	URu/YNNkdMeCU/zqmuXj+eZJHwmFBaGJNMpf7GUSRgEslvLfX7o/vIPHBdfB+zcDFM4cgnNMTfS
	K5h4oO0EEmCg==
X-Received: by 2002:a05:600c:3549:b0:492:4363:e7eb with SMTP id 5b1f17b1804b1-492668acc8cmr114223385e9.32.1782493544245;
        Fri, 26 Jun 2026 10:05:44 -0700 (PDT)
Received: from localhost ([195.94.150.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269009163sm100940205e9.11.2026.06.26.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:05:43 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 26 Jun 2026 19:09:08 +0200
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>, mbrugger@suse.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM
 controller
Message-ID: <aj6yNJQZaQviXugB@apocalypse>
References: <cover.1780670224.git.andrea.porta@suse.com>
 <350c2fb454951fd2c9d959f1d94802fea8fa8152.1780670224.git.andrea.porta@suse.com>
 <5b167316-ed50-448c-aa05-6a041a6544d5@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b167316-ed50-448c-aa05-6a041a6544d5@suse.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9424-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:svarbanov@suse.de,m:andrea.porta@suse.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:mbrugger@suse.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,devicetree.org:url,apocalypse:mid,raspberrypi.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 863EB6CF582

Hi Stan,

On 18:24 Fri 12 Jun     , Stanimir Varbanov wrote:
> 
> 
> On 6/12/26 5:01 PM, Andrea della Porta wrote:
> > From: Naushir Patuck <naush@raspberrypi.com>
> > 
> > Add the devicetree binding documentation for the PWM
> > controller found in the Raspberry Pi RP1 chipset.
> > 
> > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> > Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> >  .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
> > new file mode 100644
> > index 0000000000000..6f8461d0454f7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/raspberrypi,rp1-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Raspberry Pi RP1 PWM controller
> > +
> > +maintainers:
> > +  - Naushir Patuck <naush@raspberrypi.com>
> 
> Could you add you or me as a maintainer as well. I'm not sure Naushir
> had agreed to maintain the bindings in mainline.
> 

Sure, will do.
Thanks,

Andrea

> ~Stan

