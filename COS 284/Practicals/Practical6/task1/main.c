#include <stdlib.h>
#include <stdio.h>

struct Node
{
	char* id;
	struct
	{
		struct Node* neighbour;
		double distance;
	}* links;
	size_t nrOfLinks;
	struct
	{
		struct Node* target;
		double totalDistance;
		struct Node* nextHop;
	}* routes;
	size_t nrOfRoutes;
};

extern struct Node* allocateNode(char*);
extern void linkNodes(struct Node*, struct Node*, double);

int main()
{
  struct Node test;

	struct Node* nodeA = allocateNode("Node A");
	struct Node* nodeB = allocateNode("Node B");
	struct Node* nodeC = allocateNode("Node C");
	struct Node* nodeD = allocateNode("Node D");


	linkNodes(nodeA,nodeB,5.4);
  linkNodes(nodeC,nodeB,1.2);
	linkNodes(nodeA,nodeC,2.1);
	linkNodes(nodeA,nodeD,3.3);
  linkNodes(nodeA,nodeD,43.2);

	for (size_t i = 0; i < nodeA->nrOfLinks; i++)
	{
		printf(nodeA->links[i].neighbour->id);
		printf(" %.1f\n",nodeA->links[i].distance);
	}
	printf("\n");
	for (size_t i = 0; i < nodeB->nrOfLinks; i++)
	{
		printf(nodeB->links[i].neighbour->id);
		printf(" %.1f\n",nodeB->links[i].distance);
	}
	printf("\n");
	for (size_t i = 0; i < nodeC->nrOfLinks; i++)
	{
		printf(nodeC->links[i].neighbour->id);
		printf(" %.1f\n",nodeC->links[i].distance);
	}
	printf("\n");
	for (size_t i = 0; i < nodeD->nrOfLinks; i++)
	{
		printf(nodeD->links[i].neighbour->id);
		printf(" %.1f\n",nodeD->links[i].distance);
	}

	free(nodeD->links);
	free(nodeD->id);
	free(nodeD);
	free(nodeC->links);
	free(nodeC->id);
	free(nodeC);
	free(nodeB->links);
	free(nodeB->id);
	free(nodeB);
	free(nodeA->links);
	free(nodeA->id);
	free(nodeA);
}
