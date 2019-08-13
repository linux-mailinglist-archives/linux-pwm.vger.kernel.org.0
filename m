Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7B98BB35
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Aug 2019 16:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfHMONB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Aug 2019 10:13:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36265 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfHMONB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Aug 2019 10:13:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxXXl-000410-Ce; Tue, 13 Aug 2019 16:12:57 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxXXk-0007lN-Mu; Tue, 13 Aug 2019 16:12:56 +0200
Date:   Tue, 13 Aug 2019 16:12:56 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM
 documentation
Message-ID: <20190813141256.jnbrfld42rtigek3@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
> Add Spreadtrum PWM controller documentation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Use assigned-clock-parents and assigned-clocks to set PWM clock parent.
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> new file mode 100644
> index 0000000..e6cf312
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> @@ -0,0 +1,38 @@
> +Spreadtrum PWM controller
> +
> +Spreadtrum SoCs PWM controller provides 4 PWM channels.
> +
> +Required porperties:

s/porperties/properties/

> +- compatible : Should be "sprd,ums512-pwm".
> +- reg: Physical base address and length of the controller's registers.
> +- clocks: The phandle and specifier referencing the controller's clocks.
> +- clock-names: Should contain following entries:
> +  "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
> +  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
> +- assigned-clocks: Reference to the PWM clock entroes.

s/entroes/entries/

> +- assigned-clock-parents: The phandle of the parent clock of PWM clock.

I'm not sure you need to point out assigned-clocks and
assigned-clock-parents as this is general clk stuff. Also I wonder if
these should be "required properties".

> +- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
> +  the cells format.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
