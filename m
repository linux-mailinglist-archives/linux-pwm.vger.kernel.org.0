Return-Path: <linux-pwm+bounces-2233-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0488CDD8B
	for <lists+linux-pwm@lfdr.de>; Fri, 24 May 2024 01:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDE31C22798
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8E12881C;
	Thu, 23 May 2024 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VmDDgdVI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE629128813;
	Thu, 23 May 2024 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506215; cv=none; b=Nx9G17DRqfme55CxuCNy7aD0Houk54d3+UDU/eoWB4fDnisI3qk5U0gi7UgJhmuJ7n5Pu5R3UVGA7m7MsLhAnXrUub9IEZZg3fIcoKs7jA8VqfjSSCiNOg5mlNrC/uWQgdLSr24Z2uUCbwtq2WQXkUFGNary7SeIynWqzOZp3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506215; c=relaxed/simple;
	bh=iInzZtl5DmousXS3xfA+CEeE4VY23v6nxCWdWAghjLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPRuqoVMHajyfTDfrSlKQtDj2a+sjTLmoWr2iOo2jUOqKMic3u8YzQdZ3X53QZ9sPmjf9jRVNzFQNB8PQQh2J6o3/1nh59z9jp8BlYZGUUzwx/3LAshi020ZaTXSprh5MjCCuXISsML21edgxK9HYaIYZBJQzxhJi0DOXeTvm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VmDDgdVI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC702471;
	Fri, 24 May 2024 01:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716506198;
	bh=iInzZtl5DmousXS3xfA+CEeE4VY23v6nxCWdWAghjLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmDDgdVINI1OzSfvVRBAj+7MKw8O2pZNA/G1BjXxXPYXulqs1Gn03nWyVOudTCSb1
	 69Fc4rR6HHybg3Ve5sspfutGtklPfdKGq211nFCHiDL0ExiiDQ4R8SJW0QccMoGmeO
	 8cDtTD59Cy8kOMye0NR/FgLODYwKH6B8QG8wS6oY=
Date: Fri, 24 May 2024 02:16:41 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: Add bindings for the Analog Devices
 ADP5585
Message-ID: <20240523231641.GJ6640@pendragon.ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-3-laurent.pinchart@ideasonboard.com>
 <11a383f3-a6db-4de7-a5f8-2938c69e98fc@kernel.org>
 <20240521194309.GA8863@pendragon.ideasonboard.com>
 <075f5a03-f288-4dfb-a293-3a6c0675881b@kernel.org>
 <20240522072224.GC8863@pendragon.ideasonboard.com>
 <92e85dff-ad02-4673-a625-2248b249c262@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92e85dff-ad02-4673-a625-2248b249c262@kernel.org>

Hi Krzysztof,

(There's a question for the GPIO and PWM maintainers below)

On Wed, May 22, 2024 at 09:40:02AM +0200, Krzysztof Kozlowski wrote:
> On 22/05/2024 09:22, Laurent Pinchart wrote:
> > On Wed, May 22, 2024 at 08:57:56AM +0200, Krzysztof Kozlowski wrote:
> >> On 21/05/2024 21:43, Laurent Pinchart wrote:
> >>> On Tue, May 21, 2024 at 09:05:50PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 20/05/2024 21:59, Laurent Pinchart wrote:
> >>>>> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> >>>>> matrix decoder, programmable logic, reset generator, and PWM generator.
> >>>>> These bindings model the device as an MFD, and support the GPIO expander
> >>>>> and PWM functions.
> >>>>>
> >>>>> These bindings support the GPIO and PWM functions.
> >>>>>
> >>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>> ---
> >>>>> I've limited the bindings to GPIO and PWM as I lack hardware to design,
> >>>>> implement and test the rest of the features the chip supports.
> >>>>> ---
> >>>>>  .../bindings/gpio/adi,adp5585-gpio.yaml       |  36 ++++++
> >>>>>  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 117 ++++++++++++++++++
> >>>>>  .../bindings/pwm/adi,adp5585-pwm.yaml         |  35 ++++++
> >>>>>  MAINTAINERS                                   |   7 ++
> >>>>>  4 files changed, 195 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> >>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> >>>>>  create mode 100644 Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..210e4d53e764
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> >>>>> @@ -0,0 +1,36 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/gpio/adi,adp5585-gpio.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: Analog Devices ADP5585 GPIO Expander
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  The Analog Devices ADP5585 has up to 11 GPIOs represented by a "gpio" child
> >>>>> +  node of the parent MFD device. See
> >>>>> +  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further details as
> >>>>> +  well as an example.
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    const: adi,adp5585-gpio
> >>>>> +
> >>>>> +  gpio-controller: true
> >>>>> +
> >>>>> +  '#gpio-cells':
> >>>>> +    const: 2
> >>>>> +
> >>>>> +  gpio-reserved-ranges: true
> >>>>
> >>>> There are no resources here, so new compatible is not really warranted.
> >>>> Squash the node into parent.
> >>>
> >>> Child nodes seem (to me) to be the standard way to model functions in
> >>> MFD devices. Looking at mfd_add_device(), for OF-based systems, the
> >>> function iterates over child nodes. I don't mind going a different
> >>
> >> Only to assign of node, which could be skipped as well.
> > 
> > It has to be assigned somehow, otherwise the GPIO and PWM lookups won't
> > work. That doesn't have to be done in mfd_add_device() though, it can
> > also be done manually by the driver. Looking at the example you gave,
> > cs42l43_pin_probe() handles that assignment. I would have considered
> > that a bit of a hack, but if that's your preferred approach, I'm fine
> > with it. Could you confirm you're OK with that ?
> 
> I am fine with the drivers doing that. It's not a hack, for all
> sub-devices (e.g. also auxiliary bus) you won't have automatic of_node
> assignment.

I gave this a try, and here's what I came up with to drop the compatible
string. Please ignore for a moment the fact that the child nodes are
still there, that's an orthogonal question which I can address
separately. What I would like is feedback on how the OF nodes are
handled.

diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index 9696a4cdcfc1..8480ceef05ce 100644
--- a/drivers/gpio/gpio-adp5585.c
+++ b/drivers/gpio/gpio-adp5585.c
@@ -174,6 +174,7 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
 	struct adp5585_gpio_dev *adp5585_gpio;
 	struct device *dev = &pdev->dev;
+	struct device_node *node;
 	struct gpio_chip *gc;
 	int ret;

@@ -187,6 +188,13 @@ static int adp5585_gpio_probe(struct platform_device *pdev)

 	mutex_init(&adp5585_gpio->lock);

+	node = of_get_child_by_name(dev->parent->of_node, "gpio");
+	if (!node)
+		return dev_err_probe(dev, -ENXIO, "'gpio' child node not found\n");
+
+	dev->of_node = node;
+	dev->fwnode = &node->fwnode;
+
 	gc = &adp5585_gpio->gpio_chip;
 	gc->parent = dev;
 	gc->direction_input = adp5585_gpio_direction_input;
@@ -204,6 +212,9 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	ret = devm_gpiochip_add_data(&pdev->dev, &adp5585_gpio->gpio_chip,
 				     adp5585_gpio);
 	if (ret) {
+		of_node_put(dev->of_node);
+		dev->of_node = NULL;
+		dev->fwnode = NULL;
 		mutex_destroy(&adp5585_gpio->lock);
 		return dev_err_probe(&pdev->dev, ret, "failed to add GPIO chip\n");
 	}
@@ -215,6 +226,10 @@ static void adp5585_gpio_remove(struct platform_device *pdev)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = platform_get_drvdata(pdev);

+	of_node_put(pdev->dev.of_node);
+	pdev->dev.of_node = NULL;
+	pdev->dev.fwnode = NULL;
+
 	mutex_destroy(&adp5585_gpio->lock);
 }

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index e39a6ea5f794..3b190567ea0b 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -146,6 +146,8 @@ static const struct pwm_ops adp5585_pwm_ops = {
 static int adp5585_pwm_probe(struct platform_device *pdev)
 {
 	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct device_node *node;
 	struct pwm_chip *chip;
 	int ret;

@@ -153,16 +155,34 @@ static int adp5585_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);

+	node = of_get_child_by_name(dev->parent->of_node, "pwm");
+	if (!node)
+		return dev_err_probe(dev, -ENXIO, "'pwm' child node not found\n");
+
+	dev->of_node = node;
+	dev->fwnode = &node->fwnode;
+
 	pwmchip_set_drvdata(chip, adp5585->regmap);
 	chip->ops = &adp5585_pwm_ops;

 	ret = devm_pwmchip_add(&pdev->dev, chip);
-	if (ret)
+	if (ret) {
+		of_node_put(dev->of_node);
+		dev->of_node = NULL;
+		dev->fwnode = NULL;
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+	}

 	return 0;
 }

+static void adp5585_pwm_remove(struct platform_device *pdev)
+{
+	of_node_put(pdev->dev.of_node);
+	pdev->dev.of_node = NULL;
+	pdev->dev.fwnode = NULL;
+}
+
 static struct platform_driver adp5585_pwm_driver = {
 	.driver	= {
 		.name = "adp5585-pwm",

Is this acceptable ? I'm a bit concerned about poking the internals of
struct device directly from drivers.

I have also refrained from setting fnode->dev to point back to the
device as fone by cs42l43_pin_probe(), as a comment in struct
fwnode_handle indicates that the dev field is for device links only and
shouldn't be touched by anything else. I'm not sure if I should set it.

> >>> routes, could you indicate what you have in mind, perhaps pointing to an
> >>> existing driver as an example ?
> >>
> >> Most of them? OK, let's take the last added driver in MFD directory:
> >> cirrus,cs42l43
> >> It has three children and only two nodes, because only these two devices
> >> actually need/use/benefit the subnodes.
> > 
> > Still trying to understand what bothers you here, is it the child nodes,
> > or the fact that they have a compatible string and are documented in a
> > separate binding ? Looking at the cirrus,cs42l43 bindings and the
> 
> What bothers me (and as expressed in many reviews by us) is representing
> driver structure directly in DT. People model DT based how their Linux
> drivers are represented. I don't care about driver stuff here, but DT/DTS.

DT models the hardware as seen from a software point of view. It
shouldn't reflect the structure of Linux drivers, but it has to be
usable by drivers.

> > corresponding drivers, the pinctrl child node serves the purpose of
> > grouping properties related to the pinctrl function, and allows
> > referencing pinctrl entries from other DT nodes. All those properties
> 
> If you have sub-subnodes, it warrants for me such child. Why? Because it
> makes DTS easier to read.
> 
> > could have been placed in the parent node. Are you fine with the
> > adi,adp5585 having gpio and pwm child nodes, as long as they don't have
> > compatible strings, and are documented in a single binding ?
> 
> As well not, because then you have even less reasons to have them as
> separate nodes. With compatible, one could at least try to argue that
> sub-devices are re-usable across families.

I'll reuse your argument, I think the child nodes make the DTS easier to
read :-)

> >>>>> +required:
> >>>>> +  - compatible
> >>>>> +  - reg
> >>>>> +  - gpio
> >>>>> +  - pwm
> >>>>> +
> >>>>> +allOf:
> >>>>> +  - if:
> >>>>> +      properties:
> >>>>> +        compatible:
> >>>>> +          contains:
> >>>>> +            const: adi,adp5585-01
> >>>>> +    then:
> >>>>> +      properties:
> >>>>> +        gpio:
> >>>>> +          properties:
> >>>>> +            gpio-reserved-ranges: false
> >>>>
> >>>> This also points to fact your child node is pointless. It does not stand
> >>>> on its own...
> >>>
> >>> That doesn't make the child pointless just for that reason. There are
> >>> numerous examples of child nodes that don't stand on their own.
> >>
> >> No, your if-then must be in the schema defining it. This is just
> >> unmaintianable code. It proves that child's compatible means nothing. If
> >> you cannot use child's compatible to make any meaningful choices, then
> >> it is useless.
> > 
> > The compatible string may not be very useful. The child nodes have a
> > use.
> 
> What is their use? Grouping few properties? As mentioned above -
> grouping subnodes like pinctrl does, is argument on its own for code
> readability. Grouping few properties, which in many other devices are in
> top-node (see last 100 reviews of new drivers doing exactly the same),
> is not that argument.
> 
> OTOH, my first, main argument was:
> 
> They do not have any resources on their own. Otherwise please point me -
> which property represents their resource, like clock, reset, gpio,
> suppy, IO address?

-- 
Regards,

Laurent Pinchart

