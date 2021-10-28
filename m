Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996FA43E0F4
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Oct 2021 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhJ1M2k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Oct 2021 08:28:40 -0400
Received: from gofer.mess.org ([88.97.38.141]:54929 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhJ1M2k (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 28 Oct 2021 08:28:40 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 17D26C63F8; Thu, 28 Oct 2021 13:26:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1635423971; bh=y3qxEYJL2Lulhgp7KZQDk3Hsdwnvvf4NctUVRGbbEF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAKfVr2+8Lrq5V+B3EE3AvkB8MrOTb4CtUmbzGDrhXrZHpEITWLOCk2Eb0ubtdBok
         GMIF3E1zZcl945dli8isX1DXbSsYOFibkPUuxdpq6mJpLalTtng6+hmouQEbpPAIcC
         tQAHNXe7tp7kvosdKDTg4YjgV99xzTdUtyhbUk4o/c+oVj0PYe2//CZuL3c/6FHKnd
         sDFqkZDDD/2oPqsdkFsLJbHbByJSOEgtPLQCe1ERDKbdLTE4OCs8baN1WoZEre6qrs
         HLLp6XXEyOhV9sdJlQsXoO5BDep4KIlGQisMFMZwedHQZpVHn8FKsd2RqdiIbZHxxv
         zGXDsFmBMsrew==
Date:   Thu, 28 Oct 2021 13:26:10 +0100
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>, lkp@intel.com,
        mchehab@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211028122610.GA18767@gofer.mess.org>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org>
 <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, Oct 28, 2021 at 01:15:35PM +0200, Uwe Kleine-König wrote:
> On Thu, Oct 28, 2021 at 10:14:42AM +0100, Sean Young wrote:
> > On Thu, Oct 28, 2021 at 08:45:13AM +0200, Uwe Kleine-König wrote:
> > > The conversion is right (I think),
> > 
> > We still have the problem that the pwm drivers calculate the period
> > incorrectly by rounding down (except pwm-bcm2835). So the period is not
> > as good as it could be in most cases, but this driver can't do anything
> > about that.
> 
> Yeah, some time ago I started coding a round_state function
> (wip at
> https://git.pengutronix.de/cgit/ukl/linux/commit/?h=pwm-wip&id=ae348eb6a55d6526f30ef4a49819197d9616391e)
> but this was pushed down on my todo-list by more important stuff.

That looks great, thank you for working on that!

> If you want to experiment with that ...

I will have a look.

> > > note this could be optimized a bit
> > > further: state.period only depends on carrier which rarely changes, so
> > > the calculation could be done in pwm_ir_set_carrier(). Ditto for duty
> > > which only depends on state.period and pwm_ir->duty_cycle. (This is for
> > > a separate commit though.)
> > 
> > I'm not sure what caching this is much of a win. The calculation is a few
> > instructions, so you're not winning in the way of speed. On the flip side
> > you use more memory since pwm_state has to be kmalloc() rather than existing
> 
> I tested a bit with this patch on top of Maíra's:
> 
> 	diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> 	index 105a9c24f1e3..7585c21775bc 100644
> 	--- a/drivers/media/rc/pwm-ir-tx.c
> 	+++ b/drivers/media/rc/pwm-ir-tx.c
> 	@@ -17,7 +17,7 @@
> 	 
> 	 struct pwm_ir {
> 		struct pwm_device *pwm;
> 	-	unsigned int carrier;
> 	+	struct pwm_state state;
> 		unsigned int duty_cycle;
> 	 };
> 	 
> 	@@ -32,6 +32,7 @@ static int pwm_ir_set_duty_cycle(struct rc_dev *dev, u32 duty_cycle)
> 		struct pwm_ir *pwm_ir = dev->priv;
> 	 
> 		pwm_ir->duty_cycle = duty_cycle;
> 	+	pwm_set_relative_duty_cycle(&pwm_ir->state, pwm_ir->duty_cycle, 100);
> 	 
> 		return 0;
> 	 }
> 	@@ -43,7 +44,8 @@ static int pwm_ir_set_carrier(struct rc_dev *dev, u32 carrier)
> 		if (!carrier)
> 			return -EINVAL;
> 	 
> 	-	pwm_ir->carrier = carrier;
> 	+	pwm_ir->state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, carrier);
> 	+	pwm_set_relative_duty_cycle(&pwm_ir->state, pwm_ir->duty_cycle, 100);
> 	 
> 		return 0;
> 	 }
> 	@@ -53,21 +55,15 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
> 	 {
> 		struct pwm_ir *pwm_ir = dev->priv;
> 		struct pwm_device *pwm = pwm_ir->pwm;
> 	-	struct pwm_state state;
> 		int i;
> 		ktime_t edge;
> 		long delta;
> 	 
> 	-	pwm_init_state(pwm, &state);
> 	-
> 	-	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> 	-	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
> 	-
> 		edge = ktime_get();
> 	 
> 		for (i = 0; i < count; i++) {
> 	-		state.enabled = !(i % 2);
> 	-		pwm_apply_state(pwm, &state);
> 	+		pwm_ir->state.enabled = !(i % 2);
> 	+		pwm_apply_state(pwm, &pwm_ir->state);
> 	 
> 			edge = ktime_add_us(edge, txbuf[i]);
> 			delta = ktime_us_delta(edge, ktime_get());
> 	@@ -75,8 +71,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
> 				usleep_range(delta, delta + 10);
> 		}
> 	 
> 	-	state.enabled = false;
> 	-	pwm_apply_state(pwm, &state);
> 	+	pwm_ir->state.enabled = false;
> 	+	pwm_apply_state(pwm, &pwm_ir->state);
> 	 
> 		return count;
> 	 }
> 	@@ -95,8 +91,9 @@ static int pwm_ir_probe(struct platform_device *pdev)
> 		if (IS_ERR(pwm_ir->pwm))
> 			return PTR_ERR(pwm_ir->pwm);
> 	 
> 	-	pwm_ir->carrier = 38000;
> 	-	pwm_ir->duty_cycle = 50;
> 	+	pwm_ir->state.duty_cycle = 50;
> 	+	pwm_init_state(pwm_ir->pwm, &pwm_ir->state);
> 	+	pwm_ir_set_carrier(rcdev, 38000);
> 	 
> 		rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
> 		if (!rcdev)
> 
> bloat-o-meter reports (for an arm allmodconfig build)
> 
> 	add/remove: 0/0 grow/shrink: 3/1 up/down: 644/-396 (248)
> 	Function                                     old     new   delta
> 	pwm_ir_probe                                 372     676    +304
> 	pwm_ir_set_carrier                           108     292    +184
> 	pwm_ir_set_duty_cycle                         68     224    +156
> 	pwm_ir_tx                                    908     512    -396
> 	Total: Before=2302, After=2550, chg +10.77%

So 248 bytes more after your changes.

> struct pwm_ir increases from 12 bytes to 40 bytes.
> 
> The stack space required by pwm_ir_tx decreases from 60 to 36
> 
> I don't know exactly how kmalloc works internally. Maybe allocating a
> structure of size 40 bytes doesn't need more memory than a structure of
> size 12?
> 
> I didn't check how runtimes change, but the size decrease of pwm_ir_tx()
> is nice and might save a bit of runtime.

I'm not following, how is this decreasing runtime? 

> Probably it depends on your focus if this change is good for you or not.

Decreasing size is of course a good thing.

> > just on the stack, and both ioctl handlers and the probe function need to
> > recalculate the period/duty cycle, so there is a slight increase in code size.
> > 
> > This change does not improve anything measurably and only increases code
> > complexity.
> 
> You did measure?

Thanks for prototyping this.


Sean
