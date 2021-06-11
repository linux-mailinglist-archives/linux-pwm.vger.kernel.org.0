Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC053A3D16
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jun 2021 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhFKH3Q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Jun 2021 03:29:16 -0400
Received: from muru.com ([72.249.23.125]:41782 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231645AbhFKH3K (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 11 Jun 2021 03:29:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AED8380BA;
        Fri, 11 Jun 2021 07:27:19 +0000 (UTC)
Date:   Fri, 11 Jun 2021 10:27:08 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        linux-pwm@vger.kernel.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v3] arm: dts: ti: drop usage of redundant compatible
Message-ID: <YMMQTIIGneDZfArl@atomide.com>
References: <20210601054029.1839-1-lokeshvutla@ti.com>
 <b6b1277c-916f-49b9-cc63-1235a0c35b02@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b1277c-916f-49b9-cc63-1235a0c35b02@ti.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [210601 13:05]:
> On 01/06/2021 08:40, Lokesh Vutla wrote:
> > Commit 229110c1aa691 ("ARM: dts: am437x/am33xx/da850: Add new ECAP and
> > EPWM bindings") added ti,am3352-ehrpwm compatible which is similar to
> > ti,am33xx-ehrpwm but without out t,hwmod properties. But with commit
> > 58bfbea5b1c68 ("ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP
> > and EPWM nodes") dropped support for all ti,hwmod for ehrpwm, but
> > missed deprecating ti,am33xx-ehrpwm compatible. So drop ti,am33xx-ehrpwm
> > from DT as it is no longer needed.
> > 
> > ti-ehrpwn driver still support ti,am33xx-ehrpwm in order to maintain
> > backward compatibility.
...

> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applying into omap-for-v5.14/dt thanks.

Tony
