Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DBC35E2C2
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbhDMPYo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 11:24:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56878 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232125AbhDMPYg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Apr 2021 11:24:36 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lWKtf-0000C8-KR; Tue, 13 Apr 2021 17:24:11 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Johan Jonker <jbx6244@gmail.com>, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Date:   Tue, 13 Apr 2021 17:24:09 +0200
Message-ID: <9940894.0AQdONaE2F@diego>
In-Reply-To: <YHW3DYjr2ifBltVk@orome.fritz.box>
References: <20210412200155.5316-1-jbx6244@gmail.com> <YHW3DYjr2ifBltVk@orome.fritz.box>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

Am Dienstag, 13. April 2021, 17:21:49 CEST schrieb Thierry Reding:
> On Mon, Apr 12, 2021 at 10:01:52PM +0200, Johan Jonker wrote:
> > Current dts files with 'pwm' nodes are manually verified.
> > In order to automate this process pwm-rockchip.txt
> > has to be converted to yaml.
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> > For some SoC nodes this patch serie generates notifications
> > for undocumented "interrupts" properties shared between
> > PWM channels till there is consensus of what to do with it or
> > someone makes a solution for the whole PWM block.
> > 
> > Changed V3:
> >   fix mistake with compatibles introduced in V2
> > Changed V2:
> >   changed schema for clocks and clock-names
> > ---
> >  .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 -------
> >  .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 88 ++++++++++++++++++++++
> >  2 files changed, 88 insertions(+), 27 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> 
> Heiko, do you want to pick up patches 1 & 2 into your tree along with 3 & 4? If so:
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

however you like :-)

I can pick up everything for 5.14 for sure.

Depending on your tree-schedule for the merge-window, you could also pick
up all 4 with my:

Acked-by: Heiko Stuebner <heiko@sntech.de>


Heiko



