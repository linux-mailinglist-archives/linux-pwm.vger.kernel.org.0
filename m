Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8417A67B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2020 14:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCENgy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Mar 2020 08:36:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49797 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgCENgx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Mar 2020 08:36:53 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j9qgE-0002FX-Tj; Thu, 05 Mar 2020 14:36:50 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j9qgE-0007e3-1O; Thu, 05 Mar 2020 14:36:50 +0100
Date:   Thu, 5 Mar 2020 14:36:49 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Barker <pbarker@konsulko.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Inverted PWM output on iMX6
Message-ID: <20200305133649.bx7r7d4ntwi75qqb@pengutronix.de>
References: <20200305132232.1aced378@ub1910>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305132232.1aced378@ub1910>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Thu, Mar 05, 2020 at 01:22:32PM +0000, Paul Barker wrote:
> I recently ran into an issue using the pwm-fan driver with an inverted
> PWM output on iMX6.
> 
> The fan is defined in the device tree as follows:
> 
> 	fan0: pwm-fan {
> 		compatible = "pwm-fan";
> 		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
> 		...
> 	}
> 
> In pwm_imx27_probe() the support for a third `flags` argument in a pwm
> reference is enabled:
> 
> 	imx->chip.of_xlate = of_pwm_xlate_with_flags;
> 	imx->chip.of_pwm_n_cells = 3;
> 
> However, the flag is ignored and the output is not inverted.
> 
> By adding some prints I saw that when of_pwm_xlate_with_flags() is
> called, args->args_count is 2 instead of 3.
> 
> Looking at the definition of the pwm device itself in imx6qdl.dtsi I
> can see that the number of cells in a pwm reference is set to 2 not 3:
> 
> 	pwm2: pwm@2084000 {
> 		#pwm-cells = <2>;
> 		...
> 	};
> 
> That seems to be preventing a third argument from being passed.
> 
> I can change `#pwm-cells` to <3> and then everything works for my
> device but I'm not sure that is the correct solution for everyone. That
> would require all pwm references on iMX6 devices to use 3 cells. The
> code in of_pwm_xlate_with_flags() seems to be built to handle either 2
> or 3 argument cells but I can't see any way to allow this choice in the
> device tree.
> 
> If the solution is to set `#pwm-cells` to <3> I'm happy to send a patch
> which does this and updates all pwm references in device trees which
> include `imx6dql.dtsi`. Before I do that I'd like to know that it's the
> correct approach though.
> 
> For context I've confirmed this is the case in Linux 5.4 and that the
> relevant files haven't changed between that release and 5.6.0-rc4.

I think changing that is fine. However you'd have to care that all
in-tree users that rely on #pwm-cells = <2> are fixed accordingly.

I'd do: add #pwm-cells = <3> in the cpu.dtsi and then adapt all
machine.dts to add #pwm-cells = <2> until there are no more changes to
the generated files compared to the current state.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
